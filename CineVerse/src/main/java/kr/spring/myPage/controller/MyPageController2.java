package kr.spring.myPage.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.spring.member.vo.MemberVO;
import kr.spring.myPage.service.MyPageService;
import kr.spring.myPage.vo.MyPageVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MyPageController2 {
	@Autowired
	public MyPageService mypageService;

	//회원 정보 - 배송지 관리
	@GetMapping("/myPage/addressList")
	public String myPageAddressList(MyPageVO myPageVO, HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MyPageVO member = mypageService.selectMember(user.getMem_num());
		model.addAttribute("member",member);
		return "addressList";
	}

	// 마이페이지 구매 내역 페이지로 가기
	@GetMapping("/myPage/bought")
	public String getMyPageBought(MemberVO memberVO,HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MyPageVO member = mypageService.selectMember(user.getMem_num());
		model.addAttribute("member",member);
		return "bought";
	}

	// 마이페이지 구매 내역 상세 페이지로 가기
	@GetMapping("/myPage/boughtDetail")
	public String getMyPageDetailBought(MemberVO memberVO,HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MyPageVO member = mypageService.selectMember(user.getMem_num());
		model.addAttribute("member",member);
		return "boughtDetail";
	}
}
