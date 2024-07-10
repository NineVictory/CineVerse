package kr.spring.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


@Slf4j
@Controller
public class ShopController {
	@GetMapping("/shop/shopMain")
	public String shopMain() {
		return "shopMain";
	}
	
	@GetMapping("/shop/shopDetail")
	public String shopDetail() {
		return "shopDetail";
	}
	
	@PostMapping("/shop/shopBuy")
	public String shopBuy() {
		return "shopBuy";
	}
	
	@GetMapping("/shop/shopBasket")
	public String shopBasket() {
		return "shopBasket";
	}
	
}
