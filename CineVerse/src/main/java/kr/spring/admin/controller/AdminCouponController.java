package kr.spring.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AdminCouponController {
	
	@GetMapping("/admin/adminCoupon")
	public String adminCoupon(){
		return "adminCoupon";
	}
	
}
