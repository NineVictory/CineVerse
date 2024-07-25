package kr.spring.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import kr.spring.admin.service.AdminCouponService;
import kr.spring.board.service.BoardService;
import kr.spring.member.vo.CouponVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PagingUtil;

import org.springframework.web.bind.annotation.RequestParam;



@Slf4j
@Controller
public class AdminCouponController {

	@Autowired
	private AdminCouponService couponService;

	@GetMapping("/admin/adminCoupon")
	public String adminCoupon(){
		return "adminCoupon";
	}


	@PostMapping("/admin/adminCoupon") 
	public String insertCoupon(CouponVO
			coupon, HttpServletRequest request, HttpSession session, Model model) {
		log.debug("<<쿠폰 등록>> : " + coupon);
		if (coupon.getCoupon_min_amount() == null) {
			coupon.setCoupon_min_amount(null);
		}

		couponService.registerCoupon(coupon);

		model.addAttribute("message", "성공적으로 쿠폰이 등록되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/admin/adminCoupon");
		return "common/resultAlert"; 
	}

	@GetMapping("/admin/adminMemberCoupon")
	public String adminMemberCoupon(@RequestParam(defaultValue="1") int pageNum,
			String keyfield, String keyword, Model model, HttpServletRequest request) {
		log.debug("<<<회원 쿠폰>>>");

		Map<String, Object> map = new HashMap<>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		int count = couponService.memberCouponCount(map);

		PagingUtil page = new PagingUtil(keyfield, keyword, pageNum, count, 16, 10, "adminMemberCoupon");
		
		List<CouponVO> couponList = null;
		if(count>0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			couponList = couponService.memberCouponList(map);
		}
		
		model.addAttribute("couponList", couponList);
		model.addAttribute("count", count);
		model.addAttribute("page", page.getPage());
		
		return "adminMemberCoupon";
	}

	@GetMapping("/admin/adminCouponList")
	public String adminCouponList(@RequestParam(defaultValue="1") int pageNum,
			String keyfield, String keyword, Model model, HttpServletRequest request) {
		log.debug("<<<쿠폰 목록>>>");

		Map<String, Object> map = new HashMap<>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		int count = couponService.CouponCount(map);

		PagingUtil page = new PagingUtil(keyfield, keyword, pageNum, count, 16, 10, "adminCouponList");
		
		List<CouponVO> couponList = null;
		if(count>0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			couponList = couponService.CouponList(map);
		}
		
		model.addAttribute("couponList", couponList);
		model.addAttribute("count", count);
		model.addAttribute("page", page.getPage());
		
		return "adminCouponList";
	}

	@GetMapping("admin/modifyCoupon")
	public String modifyCouponForm(@RequestParam long coupon_num, Model model) {
		log.debug("<<<쿠폰 수정폼>>> ::: " + coupon_num);
		CouponVO couponVO = couponService.couponDetail(coupon_num);
		model.addAttribute("couponVO", couponVO);
		return "modifyCoupon";
	}
	

	@PostMapping("admin/modifyCoupon")
	public String modifyCoupon(CouponVO coupon, Model model, HttpServletRequest request) {
		log.debug("<<<쿠폰 수정하기>>> ::: " + coupon);
		
		couponService.modifyCoupon(coupon);
		
		model.addAttribute("message", "성공적으로 쿠폰이 수정되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/admin/adminCouponList");
		return "common/resultAlert"; 
	}
}
