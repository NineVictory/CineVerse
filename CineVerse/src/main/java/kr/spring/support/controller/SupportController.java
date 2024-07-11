package kr.spring.support.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class SupportController {
	@GetMapping("/support/main")
	public String main() {
		return "supportMain";
	}
	
	@GetMapping("/support/faq")
	public String faqList() {
		return "supportFaq";
	}
	
	@GetMapping("/support/news")
	public String newsList() {
		return "supportNews";
	}
	
	@GetMapping("/support/qna")
	public String qnaForm() {
		return "supportQna";
	}
}