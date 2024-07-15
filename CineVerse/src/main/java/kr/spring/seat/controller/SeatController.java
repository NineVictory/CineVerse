package kr.spring.seat.controller;

import java.io.IOException;

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

import kr.spring.seat.service.SeatService;
import kr.spring.seat.vo.SeatVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class SeatController {
	@Autowired
	private SeatService seatService;
	
	//자바빈(vo) 초기화
	@ModelAttribute
	public SeatVO initCommand() {
		return new SeatVO();
	}
	
	/*=====================
	 * 		좌석 등록
	 *=====================*/
	//등록 폼 호출
	@GetMapping("/seat/seatWrite")
	public String form() {
		return "seatWrite";
	}
	
	//등록 폼에서 전송된 데이터 처리
	@PostMapping("/seat/seatWrite")
	public String seatWrite(@Valid SeatVO seatVO, BindingResult result, HttpServletRequest request,
								HttpSession session, Model model) throws IllegalStateException, IOException{
		log.debug("<<좌석 등록>> : " + seatVO);
		
		//유효성 체크 실패 시 폼으로 다시 돌아가기
		if (result.hasErrors()) {
			return form();
		}
		
		//좌석 등록
		seatService.insertSeat(seatVO);
		
		//view 메시지 처리
		model.addAttribute("message", "좌석이 성공적으로 등록되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/seat/seatWrite");
		return "common/resultAlert";
	}
}
