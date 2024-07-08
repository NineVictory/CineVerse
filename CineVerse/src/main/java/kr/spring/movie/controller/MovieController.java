package kr.spring.movie.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;



import kr.spring.movie.vo.MovieVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MovieController {
	

	
	
	/*=======================
	 * 영화 목록
	 *=======================*/
	@GetMapping("/movie/movieList")
	public String movieList(){
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
	 * 영화 결제
	 *=======================*/
	@GetMapping("/movie/moviePayment")
	public String moviePayment(){
		return "moviePayment";
	}
	
	/*=======================
	 * 자체 영화관 정보
	 *=======================*/
	@GetMapping("/movie/ownMovieInfo")
	public String ownMovieInfo(){
		return "ownMovieInfo";
	}
	
	/*=======================
	 * 3사 영화관 정보
	 *=======================*/
	@GetMapping("/movie/otherMovieInfo")
	public String otherMovieInfo(){
		return "otherMovieInfo";
	}
	
}

