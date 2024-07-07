package kr.spring.myPage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MyPageController {
	@GetMapping("/myPage/myPageMain")
	public String myPageMain() {
		return "myPageMain";
	}
	
}
