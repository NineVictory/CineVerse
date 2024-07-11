package kr.spring.cinema.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.spring.cinema.service.CinemaService;
import kr.spring.cinema.vo.CinemaVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CinemaController {
	@Autowired
	private CinemaService cinemaService;
	
	//자바빈(VO) 초기화
	@ModelAttribute
	public CinemaVO initCommand() {
		return new CinemaVO();
	}
	
	/*==============================
	 * 		영화관 등록
	 *==============================*/	
	
	
	/*==============================
	 * 		영화관 목록
	 *==============================*/
	@GetMapping("/movie/ownMovieInfo")
	public String ownMovieInfo(){
		
		
		return "ownMovieInfo";
	}
	
	
	/*==============================
	 * 		영화관 정보 상세보기
	 *==============================*/
	
	/*==============================
	 * 		영화관 정보 수정
	 *==============================*/
	
	/*==============================
	 * 		영화관 정보 삭제
	 *==============================*/
	
}
