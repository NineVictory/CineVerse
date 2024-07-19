package kr.spring.support.controller;

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
import org.springframework.web.servlet.ModelAndView;

import kr.spring.board.service.BoardService;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.support.service.SupportService;
import kr.spring.support.vo.ConsultVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class SupportController {
	
	@Autowired
	private SupportService supportService;
	
	@Autowired
	private MemberService memberService;
	
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
	public ModelAndView consultForm(Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		MemberVO db_member = memberService.selectCheckMember(user.getMem_id());
		ModelAndView modelAndView = new ModelAndView("supportConsult");
		
		model.addAttribute("user", db_member);
		
		return modelAndView;
	}
	
	@PostMapping("/support/consult")
	public String consultSubmit(@Valid ConsultVO consultVO, BindingResult result, Model model, HttpServletRequest request) {
		log.debug("<<문의>> : " + consultVO);
		
		if(result.hasErrors()) {
			return "supportConsult";
		}
		
		consultVO.setConsult_ip(request.getRemoteAddr());
		
		supportService.insertConsult(consultVO);
		
		model.addAttribute("message", "문의 등록 완료");
		model.addAttribute("url", request.getContextPath() + "/support/main");
		return "common/resultAlert";
	}
	
}