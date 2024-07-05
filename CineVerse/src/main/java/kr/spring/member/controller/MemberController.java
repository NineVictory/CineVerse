package kr.spring.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {
	
	@GetMapping("/member/login")
	public String memberLogin() {
		return "memberLogin";
	}
	
	@GetMapping("/member/register")
	public String memberRegister() {
		return "memberRegister";
	}
	
}
