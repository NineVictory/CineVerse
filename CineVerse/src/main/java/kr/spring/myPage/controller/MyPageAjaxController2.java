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

}
