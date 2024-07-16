package kr.spring.myPage.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.vo.MemberVO;
import kr.spring.myPage.service.MyPageService;
import kr.spring.myPage.service.MyPageService2;
import kr.spring.shop.service.ShopService;
import kr.spring.shop.vo.PBasketVO;
import kr.spring.shop.vo.ProductVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MyPageAjaxController2 {
	@Autowired
	private ShopService shopService;

	@Autowired
	private MyPageService2 mypageService2;

	@Autowired
	private MyPageService mypageService;

	// 주문 확정하기
	@PostMapping("/myPage/orderConfirm")
	@ResponseBody
	public Map<String, Object> orderConfirm(@RequestParam long order_number, @RequestParam long mem_num, HttpSession session) {
		log.debug("<<주문 확정 - order_num>> ::: " + order_number);
		log.debug("<<주문 확정 - mem_num>> ::: " + mem_num);

		Map<String, Object> mapJson = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("user");

		if (user == null) { // 로그아웃 상태
			mapJson.put("result", "logout");
		} else if(user.getMem_num()!=mem_num) {
			mapJson.put("result", "wrongAccess");
		} else {
			shopService.orderConfirm(order_number);
			mapJson.put("result", "success");
		}

		return mapJson;
	}
	
	// 상품 리뷰 쓰기
	@PostMapping("/myPage/productReview")
	@ResponseBody
	public Map<String, Object> productReview(@RequestParam long od_num, @RequestParam long p_num, @RequestParam long pr_grade, @RequestParam String pr_content, HttpSession session) {
		log.debug("<<리뷰 쓰기 - od_num, p_num, pr_grade>> ::: " + od_num + ", " + p_num + ", " + pr_grade);
		log.debug("<<리뷰 쓰기 - pr_content>> ::: " + pr_content);
		Map<String, Object> mapJson = new HashMap<String, Object>();
		ProductVO product = new ProductVO();
		
		MemberVO user = (MemberVO) session.getAttribute("user");

		if (user == null) { // 로그아웃 상태
			mapJson.put("result", "logout");
		} else {
			product.setPr_content(pr_content);
			product.setOd_num(od_num);
			product.setPr_grade(pr_grade);
			product.setP_num(p_num);
			shopService.writeProductReview(product);
			
			long order_num = shopService.selectOrderNum(od_num);
			
			int countReview = shopService.countReview(order_num);
			int countOrderDetail = shopService.countOrderDetail(order_num);
			if(countReview==countOrderDetail) {
				shopService.updateOrderReStatus(order_num);
				mapJson.put("result", "complete");
			} else {
				mapJson.put("result", "success");
			}
			
		}
		
		return mapJson;
	}
	

}
