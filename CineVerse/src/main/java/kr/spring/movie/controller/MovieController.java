package kr.spring.movie.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.board.vo.BoardVO;
import kr.spring.cinema.service.CinemaService;
import kr.spring.cinema.vo.CinemaVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.movie.service.MovieService;
import kr.spring.movie.vo.MovieVO;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MovieController {
	
	@Autowired
	private MovieService movieService;
	
	@Autowired
	private CinemaService cinemaService;
		
	/*=======================
	 * 영화 목록
	 *=======================*/
	@GetMapping("/movie/movieList")
	public String movieList(@RequestParam(defaultValue = "1") int pageNum,
			  				@RequestParam(defaultValue = "1") int movieorder,
			  				
			  String keyfield, String keyword, Model model) {
		
		log.debug("<<게시판 목록 - movieorder>> :"+movieorder); //정렬
		
		
		Map<String,Object> map = new HashMap<String,Object>();

		map.put("keyfield",keyfield);
		map.put("keyword",keyword);
		
		//전체,검색 레코드 수
		int count = movieService.selectMovieRowCount(map);
		
		//페이지 처리
				PagingUtil page = 
						new PagingUtil(keyfield,keyword, pageNum,
											count,20,10,"movielist",
											"&movieorder="+movieorder);
				List<MovieVO> movielist = null;
				if(count >0) {
					map.put("movieorder",movieorder);
					map.put("start",page.getStartRow());
					map.put("end",page.getEndRow());
					
					movielist = movieService.selectMovieList(map);
				}
				model.addAttribute("count",count);
				model.addAttribute("movielist",movielist);
				model.addAttribute("page",page.getPage());
		
		return "movieList";
	}
	
	/*=======================
	 * 영화 상세
	 *=======================*/
	@GetMapping("/movie/movieDetail")
    public String movieDetail(@RequestParam int m_code, HttpSession session, Model model) {
        MemberVO user = (MemberVO) session.getAttribute("user");
        long userMemNum = user != null ? user.getMem_num() : -1L; // long 타입으로 변경
        
        MovieVO movie = movieService.selectMovie(m_code);
        boolean canWriteReview = movieService.canWriteReview(userMemNum, m_code);
        
        model.addAttribute("movie", movie);
        model.addAttribute("canWriteReview", canWriteReview);
        return "movieDetail";
    }
	
	/*=======================
	 * 영화 예매 
	 *=======================*/
	 @GetMapping("/movie/movieReserve")
	    public String movieReserve(@RequestParam(defaultValue = "1") int pageNum,
	                               @RequestParam(defaultValue = "1") int order,
	                               @RequestParam(defaultValue = "1") String c_location,
	                               String keyfield, String keyword, Model model) {
		 	
		 
			log.debug("<<영화관 목록 - c_location>> : " + c_location);
			log.debug("<<영화관 목록 - order>> : " + order);
			
			
	        Map<String, Object> map = new HashMap<>();
	        map.put("c_location", c_location);
	        map.put("keyfield", keyfield);
	        map.put("keyword", keyword);

	        // 전체, 검색 레코드 수
	        int count = cinemaService.selectCinemaCount(map);

	        // 페이지 처리
	        PagingUtil page = new PagingUtil(keyfield, keyword, pageNum, count, 20, 10, "movieReserve", "&c_location=" + c_location + "&order=" + order);
	        List<CinemaVO> list = null;
	        if (count > 0) {
	            map.put("order", order);
	            map.put("start", page.getStartRow());
	            map.put("end", page.getEndRow());

	            list = cinemaService.selectCinemaList(map);
	        }
	        

	        model.addAttribute("count", count);
	        model.addAttribute("list", list);
	        model.addAttribute("page", page.getPage());

	        return "movieReserve";
	    }
	 	
	 	//지점명 선택했을 때 영화목록 불러오기
	 	@GetMapping("/getMoviesByCinema")
	    @ResponseBody
	    public List<MovieVO> getMoviesByCinema(long c_num) {
	        return cinemaService.getMoviesByCinema(c_num);
	    }
	
	/*=======================
	 * 영화 좌석 선택
	 *=======================*/
	@GetMapping("/movie/movieSeat")
	public String movieSeat(){
		return "movieSeat";
	}
	
	/*=======================
	 * 영화 결제
	 *=======================*/
	@GetMapping("/movie/moviePayment")
	public String moviePayment(){
		return "moviePayment";
	}
	
	/*=======================
	 * 영화 상영시간표
	 *=======================*/
	@GetMapping("/movie/movieTime")
	public String movieTime(){
		return "movieTime";
	}
	 	
	
	/*=======================
	 * 3사 영화관 정보
	 *=======================*/
	@GetMapping("/movie/otherMovieInfo")
	public String otherMovieInfo(){
		return "otherMovieInfo";
	}
	
}

