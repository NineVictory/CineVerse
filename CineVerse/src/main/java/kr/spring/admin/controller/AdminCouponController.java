package kr.spring.admin.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import kr.spring.admin.service.AdminCouponService;
import kr.spring.admin.service.AdminService;
import kr.spring.admin.vo.AdminVO;
import kr.spring.admin.vo.EventVO;
import kr.spring.admin.vo.EventVO2;
import kr.spring.board.service.BoardService;
import kr.spring.member.vo.CouponVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;

import org.springframework.web.bind.annotation.RequestParam;



@Slf4j
@Controller
public class AdminCouponController {

	@Autowired
	private AdminCouponService couponService;


	@Autowired
	private AdminService adminService;


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
		model.addAttribute("url", request.getContextPath() + "/admin/adminCouponList");
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

	@GetMapping("admin/deleteMemberCoupon")
	public String deleteMemberCoupon(@RequestParam long mc_num, Model model, HttpServletRequest request) {
		log.debug("<<<회원 쿠폰 삭제>>> ::: " + mc_num);

		couponService.deleteMemberCoupon(mc_num);

		model.addAttribute("message", "성공적으로 쿠폰이 삭제되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/admin/adminMemberCoupon");
		return "common/resultAlert"; 
	}

	@GetMapping("admin/couponSend")
	public String couponSend(@RequestParam long coupon_num, @RequestParam(defaultValue="1") int pageNum,
			String keyfield,String keyword, Model model, HttpServletRequest request) {
		log.debug("<<<회원 쿠폰 지급>>> ::: " + coupon_num);

		Map<String,Object> map = 
				new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		//전체,검색 레코드수
		int count = adminService.selectMemberRowCount(map);

		//페이지 처리
		PagingUtil page = 
				new PagingUtil(keyfield,keyword,pageNum,
						count,10,10,"admin/adminCouponSend?coupon_num=" + coupon_num);

		List<AdminVO> list = null;

		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list = adminService.selectMemberList(map);
		}

		model.addAttribute("coupon_num", coupon_num);
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());


		return "adminCouponSend"; 
	}

	@GetMapping("admin/couponSendMember")
	public String couponSendMember(@RequestParam long coupon_num, @RequestParam long mem_num ,Model model, HttpServletRequest request) {

		couponService.couponSendMember(coupon_num, mem_num);

		model.addAttribute("message", "성공적으로 쿠폰이 지급되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/admin/adminCouponList");
		return "common/resultAlert"; 
	}


	// 급한 관계로 여기에 크라우드 소싱 
	@GetMapping("/admin/adminCrowdForm")
	public String AdminCrowdForm(Model model){
		model.addAttribute("eventVO", new EventVO2());
		   
		return "adminCrowdForm";
	}
	
	@PostMapping("admin/adminCrowdForm")
	public String insertCrowd(@Valid EventVO2 eventVO2,
			BindingResult result,
			HttpServletRequest request,
			HttpSession session,
			Model model) throws IllegalStateException,IOException{
		
		log.debug("<<크라우드 소싱 등록>> ::: " + eventVO2);

		if(eventVO2.getEvent_upload()==null || eventVO2.getEvent_upload().isEmpty()) {
			result.rejectValue("event_upload","fileNotFound");
		}

		if (result.hasErrors()) {
			log.debug("<<유효성검사이상있음>> : " + eventVO2);
			return "adminCrowdForm"; 
		}

		eventVO2.setEvent_filename(FileUtil.createFile(request, 
				eventVO2.getEvent_upload()));

		log.debug("파일명: " + eventVO2.getEvent_filename());
		couponService.insertCrowd(eventVO2);
		
		//View 메시지 처리
		model.addAttribute("message", "성공적으로 크라우드 소싱이 등록되었습니다.");
		model.addAttribute("url", 
				request.getContextPath()+"/admin/adminEvent");

		return "common/resultAlert";
	}
}
