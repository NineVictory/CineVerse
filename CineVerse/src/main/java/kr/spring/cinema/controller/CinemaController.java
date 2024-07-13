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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.cinema.service.CinemaService;
import kr.spring.cinema.vo.CinemaVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CinemaController {
	@Autowired
	private CinemaService cinemaService;

	// 자바빈(VO) 초기화
	@ModelAttribute
	public CinemaVO initCommand() {
		return new CinemaVO();
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
					
		return new ModelAndView("cinemaDetail2","cinema",cinema);
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
