package kr.spring.movie.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.board.vo.BoardVO;
import kr.spring.movie.vo.MovieVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MovieController {
	
	//자바빈(VO) 초기화
		@ModelAttribute
		public MovieVO initCommand() {
			return new MovieVO();
		}
	/*=======================
	 * 영화 등록
	*=======================*/
	//등록 폼 호출
	@GetMapping("/movie/write")
	public String form() {
		return "movieWrite";
	}	
		
	/*=======================
	 * 영화 목록
	 *=======================*/
	@GetMapping("/movie/movieList")
	public String movieList(@RequestParam(defaultValue = "1") int pageNum,
			  				@RequestParam(defaultValue = "1") int order,
			  				
			  String keyfield, String keyword, Model model) {
		
		log.debug("<<게시판 목록 - order>> :"+order); //정렬
		
		return "movieList";
	}
	
	/*=======================
	 * 영화 상세
	 *=======================*/
	@GetMapping("/movie/movieDetail")
	public String movieDetail(){
		return "movieDetail";
	}
	
	/*=======================
	 * 영화 예매
	 *=======================*/
	@GetMapping("/movie/movieReserve")
	public String movieReserve(){
		return "movieReserve";
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

