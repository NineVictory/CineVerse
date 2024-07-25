package kr.spring.admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import kr.spring.member.vo.MemberVO;


@Slf4j
@Controller
public class AdminCouponController {
	
	@GetMapping("/admin/adminCoupon")
	public String adminCoupon(){
		return "adminCoupon";
	}
	
	/*
	 * @PostMapping("/admin/adminCoupon") public String insertCoupon(CouponVO
	 * coupon, HttpServletRequest request, HttpSession session, Model model) {
	 * log.debug("<<쿠폰 등록>> : " + coupon);
	 * 
	 * //View 메시지 처리 model.addAttribute("message", "성공적으로 쿠폰이 등록되었습니다.");
	 * model.addAttribute("url", request.getContextPath() + "/admin/adminCoupon");
	 * return "common/resultAlert"; }
	 */
	
}
