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
	
	//고객센터 메인
	@GetMapping("/support/main")
	public String main() {
		return "supportMain";
	}
	
	//자주묻는질문
	@GetMapping("/support/faq")
	public String faqList() {
		return "supportFaq";
	}
	
	//공지/뉴스
	@GetMapping("/support/notice")
	public String noticeList() {
		return "supportNotice";
	}
	//1:1문의
	@GetMapping("/support/consult")
	public String consultForm() {
		return "supportConsult";
	}
	
}