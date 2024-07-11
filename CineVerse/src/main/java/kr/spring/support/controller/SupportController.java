package kr.spring.support.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.spring.board.service.BoardService;
import kr.spring.support.service.SupportService;
import kr.spring.support.vo.ConsultVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class SupportController {
	
	@Autowired
	private SupportService supportService;
	
	@ModelAttribute
	public ConsultVO initCommand() {
		return new ConsultVO();
	}
	
	@GetMapping("/support/main")
	public String main() {
		return "supportMain";
	}
	
	@GetMapping("/support/faq")
	public String faqList() {
		return "supportFaq";
	}
	
	@GetMapping("/support/notice")
	public String noticeList() {
		return "supportNotice";
	}
	
	@GetMapping("/support/consult")
	public String consultForm() {
		return "supportConsult";
	}
	
}