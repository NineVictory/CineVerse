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
	//등록 폼 호출
	@GetMapping("/movie/cinemaWrite")
	public String form() {
		return "cinemaWrite";
	}
	//등록 폼에서 전송된 데이터 처리
	@PostMapping("movie/cinemaWrite")
	public String cinemaWrite(@Valid CinemaVO cinemaVO, BindingResult result, HttpServletRequest request, HttpSession session, Model model)
																										throws IllegalStateException, IOException{
		log.debug("<<영화관 등록>> : " + cinemaVO);
		
		//유효성 체크 실패시 폼으로 다시 돌아가기
		if(result.hasErrors()) {
			return form();
		}

		//글쓰기
		cinemaService.insertCinema(cinemaVO);
		
		//view 메시지 처리
		model.addAttribute("message","영화가 성공적으로 등록되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/movie/ownMovieInfo");
		
		return "common/resultAlert";
	}
	
	/*==============================
	 * 		영화관 목록
	 *==============================*/
	@GetMapping("/movie/ownMovieInfo")
	public String ownMovieInfo(Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		List<CinemaVO> list = null;
		list = cinemaService.selectCinemaList(map);
		model.addAttribute("list", list);
		
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
