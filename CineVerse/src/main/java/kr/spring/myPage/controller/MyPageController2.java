package kr.spring.myPage.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.spring.member.vo.MemberVO;
import kr.spring.myPage.service.MyPageService;
import kr.spring.myPage.service.MyPageService2;
import kr.spring.myPage.vo.AddressVO;
import kr.spring.myPage.vo.MyPageVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MyPageController2 {
	@Autowired
	public MyPageService mypageService;

	@Autowired
	public MyPageService2 mypageService2;
	
	//회원 정보 - 배송지 관리
	@GetMapping("/myPage/addressList")
	public String myPageAddressList(MyPageVO myPageVO, HttpSession session, Model model) {
	    log.debug("<<배송지 관리>> ::: 진입 성공");
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    MyPageVO member = mypageService.selectMember(user.getMem_num());
	    model.addAttribute("member", member);
	    
	    Integer count = mypageService2.countAddress(user.getMem_num());
	    List<AddressVO> addressList = mypageService2.addressList(user.getMem_num());
	    
	    model.addAttribute("count", count);
	    model.addAttribute("addressList", addressList); // 'addressList'로 변경
	    model.addAttribute("address", new AddressVO()); // 폼에 사용될 객체 추가
	    return "addressList";
	}
	
	
	
	// 배송지 추가
	@PostMapping("/myPage/addAddress")
	public String addAddress(@Valid AddressVO address, BindingResult result, HttpServletRequest request, HttpSession session, Model model)throws IllegalStateException,IOException {
		log.debug("<<배송지 추가>> ::: " + address);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return "addressList";
		}
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		address.setMem_num(user.getMem_num());
		
		mypageService2.addAddress(address);
		
		model.addAttribute("message", "성공적으로 배송지가 추가되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/myPage/addressList");
		return "common/resultAlert";
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
