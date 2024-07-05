package kr.spring.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {
	
	@Autowired
	public MemberService memberService;
	
	@ModelAttribute
	public MemberVO initCommand() {
		return new MemberVO();
	}
	
	@GetMapping("/member/register")
	public String memberRegisterForm() {
		return "memberRegister";
	}
	
	@PostMapping("/member/register")
	public String memberRegister(@Valid MemberVO memberVO, BindingResult result, Model model, HttpServletRequest request) {
		log.debug("<<회원 가입>> : " + memberVO);
		
		if(result.hasErrors()) {
			return memberRegisterForm();
		}
		
		memberService.insertMember(memberVO);
		
		//  UI 문구 처리
		model.addAttribute("message","회원 가입이 완료되었습니다");
		model.addAttribute("url", request.getContextPath()+"/main/main");
		return "common/resultAlert";
	}
	
	@GetMapping("/member/login")
	public String memberLogin() {
		return "memberLogin";
	}
	
}
