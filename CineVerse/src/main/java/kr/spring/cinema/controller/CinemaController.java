package kr.spring.cinema.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.admin.service.AdminService;
import kr.spring.cinema.service.CinemaService;
import kr.spring.cinema.vo.CinemaVO;
import kr.spring.cinema.vo.TheaterVO;
import kr.spring.movie.vo.MovieTimeVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CinemaController {
	@Autowired
	private CinemaService cinemaService;

	// 자바빈(CinemaVO) 초기화
    @ModelAttribute("cinemaVO")
    public CinemaVO initCinemaCommand() {
        return new CinemaVO();
    }

    // 자바빈(TheaterVO) 초기화
    @ModelAttribute("theaterVO")
    public TheaterVO initTheaterCommand() {
        return new TheaterVO();
    }
	

	/*=====================
	 * 영화관 등록
	 *=====================*/
	// 등록 폼 호출
	@GetMapping("/cinema/cinemaWrite")
	public String form() {
		return "cinemaWrite";
	}

	// 등록 폼에서 전송된 데이터 처리
	@PostMapping("cinema/cinemaWrite")
	public String cinemaWrite(@Valid CinemaVO cinemaVO, BindingResult result, HttpServletRequest request,
			HttpSession session, Model model) throws IllegalStateException, IOException {
		log.debug("<<영화관 등록>> : " + cinemaVO);

		// 유효성 체크 실패시 폼으로 다시 돌아가기
		if (result.hasErrors()) {
			return form();
		}

		// 영화 등록 메서드
		cinemaService.insertCinema(cinemaVO);

		// view 메시지 처리
		model.addAttribute("message", "영화가 성공적으로 등록되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/cinema/cinemaList2");

		return "common/resultAlert";
	}

	
	/*=====================
	 * 영화관 목록
	 *=====================*/
	@GetMapping("/cinema/cinemaList2")
	public String getList(
			 @RequestParam(defaultValue="1") int pageNum,
			 @RequestParam(defaultValue="1") int order,
			 @RequestParam(defaultValue="1") String c_location,
			 String keyfield,String keyword,Model model) {
		
		log.debug("<<영화관 목록 - c_location>> : " + c_location);
		log.debug("<<영화관 목록 - order>> : " + order);
		
		Map<String,Object> map =  new HashMap<String,Object>();
		map.put("c_location", c_location);
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체,검색 레코드수
		int count = cinemaService.selectCinemaCount(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,pageNum,
						       count,20,10,"cinemaList2", "&c_location="+c_location+"&order="+order);
		List<CinemaVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = cinemaService.selectCinemaList(map);
		}
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
		
		return "cinemaList2";
	}
	
	/*=====================
	 * 영화관 상세 정보
	 *=====================*/
	@GetMapping("/cinema/detail")
	public ModelAndView process(long c_num) {
		log.debug("<<영화관 상세 - c_num>> : " + c_num);
	
		CinemaVO cinema = cinemaService.selectCinema(c_num);
					
		// 상영관 목록 조회
        List<TheaterVO> theaterList = cinemaService.selectTheaterListByCinemaNum(c_num);
        
        // 상영관 수 조회
        Integer theaterCount = cinemaService.selectTheaterCountByCinema(c_num);
        
        // 상영 시간표 조회
        //List<MovieTimeVO> movieTimeList = cinemaService.selectMovieTimeListByCinemaNum(c_num);
        
        
        
        ModelAndView mav = new ModelAndView("cinemaDetail2");
        mav.addObject("cinema", cinema);
        mav.addObject("theaterList", theaterList);
        mav.addObject("theaterCount", theaterCount); 
        //mav.addObject("movieTimeList", movieTimeList);
        return mav;
		/* return new ModelAndView("cinemaDetail2","cinema",cinema); */
	}
	
	
	/*=====================
	 * 영화관 정보 삭제
	 *=====================*/
	@GetMapping("/cinema/delete")
	public String submitDelete(long c_num,  HttpServletRequest request) {
		log.debug("<<영화관 삭제 - c_num>> : " + c_num);

		//글 삭제
		cinemaService.deleteCinema(c_num);
		
		return "redirect:/cinema/cinemaList2";
	}
	
	
	/*=====================
	 * 영화관 정보 수정
	 *=====================*/
	//수정 폼 호출
	@GetMapping("/cinema/update")
	public String formUpdate(long c_num,Model model) {
		CinemaVO cinemaVO = 
				cinemaService.selectCinema(c_num);
		model.addAttribute("cinemaVO", cinemaVO);
		
		return "cinemaModify";
	}
	//수정 폼에서 전송된 데이터 처리
	@PostMapping("/cinema/update")
	public String submitUpdate(@Valid CinemaVO cinemaVO,BindingResult result, Model model,
			                   HttpServletRequest request) throws IllegalStateException, IOException {
		log.debug("<<영화관 정보 수정>> : " + cinemaVO);
		
		/*
		 * //유효성 체크 결과 오류가 있으면 폼 호출 if(result.hasErrors()) {
		 * 
		 * CinemaVO vo = cinemaService.selectCinema(cinemaVO.getC_num()); return
		 * "cinemaModify"; }
		 * 
		 * //DB에 저장된 파일 정보 구하기 CinemaVO db_cinema =
		 * cinemaService.selectCinema(cinemaVO.getC_num());
		 */
		
		//영화관 정보 수정
		cinemaService.updateCinema(cinemaVO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "영화관 정보 수정 완료!!");
		model.addAttribute("url", request.getContextPath() + "/cinema/detail?c_num=" +cinemaVO.getC_num());
		
		return "common/resultAlert";
	}
	
	
	
	/*========================
	 * 예매 페이지 영화 목록 불러오기 
	 *========================*/
	 //지점명 선택했을 때 영화목록 불러오기
	
		/*
		 * @GetMapping("/movieReserveList")
		 * 
		 * @ResponseBody public List<MovieTimeVO> movieReserveList(long c_num) { return
		 * cinemaService.movieReserveList(c_num); }
		 */
	
	 @GetMapping("/movieReserveList")
	    @ResponseBody
	    public List<MovieTimeVO> movieReserveList(@RequestParam long c_num, @RequestParam(defaultValue = "default") String sort) {
	        if ("reservation".equals(sort)) {
	            return cinemaService.getMoviesSortedByReservationRate(c_num);
	        } else if ("korean".equals(sort)) {
	            return cinemaService.getMoviesSortedByName(c_num);
	        } else {
	            return cinemaService.getDefaultMovieList(c_num); // 최신순 정렬
	        }
	    }
	
	
	
	
	
	 	/*========================
	  	* 등록된 상영시간표 관리 [관리자용]
	  	*========================*/
	 @GetMapping("/admin/adminTimeControll")
	   public String adminTimeControll(@RequestParam(defaultValue = "1") int pageNum,
									   @RequestParam(value = "keyword", required = false) String keyword,
				                       @RequestParam(value = "keyfield", required = false) String keyfield,Model model){
		// keyfield가 없으면 기본값을 설정
			if (keyfield == null || keyfield.isEmpty()) {
				keyfield = "mt_date"; // 기본 검색 필드를 설정합니다.
			}

			// 파라미터를 맵에 추가
			Map<String, Object> map = new HashMap<>();
			map.put("keyword", keyword);
			map.put("keyfield", keyfield);

			// 전체, 검색 레코드 수
			int count = cinemaService.controllMovieTimeRowCount(map);

			// 페이지 처리
			PagingUtil page = new PagingUtil(keyfield, keyword, pageNum, count, 10, 10, "adminTimeControll");

			List<MovieTimeVO> list = null; 
			if (count > 0) {
				map.put("start", page.getStartRow());
				map.put("end", page.getEndRow());

				list = cinemaService.controllMovieTime(map); 
			}

			model.addAttribute("count", count);
			model.addAttribute("list", list);
			model.addAttribute("page", page.getPage());

	      return "adminTimeControll";
	   }
	
	 	// 영화 시간표 처리
	 	@PostMapping("/deleteTimeControll")
	 	@ResponseBody 
		public String deleteMovieTime(@RequestParam("mt_num") long mt_num) {
			//글 삭제
			cinemaService.deleteMovieTime(mt_num);
			return "success";
		}
	 	
	 	//영화시간표 수정 폼 호출
	 			@GetMapping("/admin/adminMtModify")
	 			public String adminMtModify(long mt_num,Model model){
	 				MovieTimeVO movieTimeVO=
	 						cinemaService.getMovieTimeById(mt_num);
	 				model.addAttribute("movieTimeVO",movieTimeVO);
	 				return "adminMtModify";
	 				
	 			}
	 			
	 			
	 	//영화시간표 수정
	 			@PostMapping("/admin/adminMtModify")
	 			public String modifyMovie(@Valid MovieTimeVO movieTimeVO,
	 					BindingResult result,
	 					HttpServletRequest request,
	 					Model model) throws IllegalStateException,IOException{
	 				log.debug("<<공지사항 글 저장>> : " + movieTimeVO);

	 				
	 				cinemaService.updateMovieTime(movieTimeVO);
	 				//View 메시지 처리
	 				model.addAttribute("message", "성공적으로 글이 수정되었습니다.");
	 				model.addAttribute("url", 
	 						request.getContextPath()+"/admin/adminTimeControll");
	 	 
	 				return "common/resultAlert";
	 			}
	
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	/*=====================
	 * 상영관 등록
	 *=====================*/
	/*
	 * @GetMapping("/cinema/theaterWrite") public String showTheaterWriteForm(Model
	 * model, @RequestParam String c_location) { List<String> branchList =
	 * cinemaService.selectCinemaBranches(c_location);
	 * 
	 * model.addAttribute("branchList", branchList); model.addAttribute("theaterVO",
	 * new TheaterVO()); // TheaterVO 초기화
	 * 
	 * return "theaterWrite"; }
	 * 
	 * // 등록 폼에서 전송된 데이터 처리
	 * 
	 * @PostMapping("cinema/theaterWrite") public String theaterWrite(@Valid
	 * TheaterVO theaterVO, BindingResult result, HttpServletRequest request,
	 * HttpSession session, Model model) throws IllegalStateException, IOException {
	 * log.debug("<<상영관 등록>> : " + theaterVO);
	 * 
	 * // 유효성 체크 실패시 폼으로 다시 돌아가기 if (result.hasErrors()) { return "theaterWrite"; }
	 * 
	 * // 상영관 등록 메서드 cinemaService.insertTheater(theaterVO);
	 * 
	 * // view 메시지 처리 model.addAttribute("message", "상영관이 성공적으로 등록되었습니다.");
	 * model.addAttribute("url", request.getContextPath() + "/cinema/cinemaList2");
	 * 
	 * return "common/resultAlert"; }
	 */
	
	

	
	
	/*
	 * ============================== 영화관 지점명 보기 ==============================
	 * 
	 * @GetMapping("/cinema/cinemaList")
	 * 
	 * @ResponseBody public Map<String, Object> cinemaList(int c_location){
	 * 
	 * List<CinemaVO> list = cinemaService.selectCinemaList(c_location);
	 * 
	 * Map<String, Object> mapJson = new HashMap<String, Object>();
	 * mapJson.put("list", list);
	 * 
	 * return mapJson; }
	 * 
	 * 
	 * ============================== 지점 상세 정보 확인 ==============================
	 * 
	 * @GetMapping("/cinema/cinemaDetail") public String cinemaDetail(){
	 * 
	 * return "cinemaDetail"; }
	 */
}
