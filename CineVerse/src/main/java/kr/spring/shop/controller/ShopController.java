package kr.spring.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ShopController {
	@GetMapping("/shop/shopMain")
	public String shopMain() {
		return "shopMain";
	}
	
}
