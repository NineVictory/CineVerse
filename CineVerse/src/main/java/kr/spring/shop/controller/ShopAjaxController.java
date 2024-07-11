package kr.spring.shop.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import kr.spring.member.vo.MemberVO;
import kr.spring.shop.service.ShopService;
import kr.spring.shop.vo.ProductVO;
import lombok.extern.slf4j.Slf4j;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;


@Slf4j
@Controller
public class ShopAjaxController {
	@Autowired
	private ShopService shopService;

	// 관심 상품 불러오기
	@GetMapping("/shop/getProductFav")
	@ResponseBody
	public Map<String, Object> getProjectFav(ProductVO fav, HttpSession session){
		log.debug("<<관심 상품>> ::: " + fav);
		Map<String, Object> mapJson = new HashMap<String, Object>();

		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("status", "noFav");
		}else {
			fav.setMem_num(user.getMem_num());
			ProductVO productFav = shopService.selectProductFav(fav);
			if(productFav==null) {
				mapJson.put("status", "noFav");
			} else {
				mapJson.put("status", "yesFav");
			}
		}
		mapJson.put("count", shopService.productFavCount(fav.getP_num()));
		return mapJson;

	}

	// 관심 상품 하기, 관심 상품 취소하기
	@PostMapping("/shop/productFav")
	@ResponseBody
	public Map<String, Object> productFav(ProductVO fav, HttpSession session) {
		log.debug("<<관심 상품 등록 취소>> ::: " + fav);

		Map<String, Object> mapJson = new HashMap<String, Object>();

		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "logout");
		} else {
			fav.setMem_num(user.getMem_num());
			ProductVO productFav = shopService.selectProductFav(fav);
			if(productFav==null) {
				// 찜한 적 없을 때는 찜할 수 있게
				shopService.ProductFav(fav);
				mapJson.put("status", "yesFav");
			} else {
				shopService.ProductFavDelete(fav);
				mapJson.put("status", "noFav");
			}
			mapJson.put("result", "success");
			mapJson.put("count", shopService.productFavCount(fav.getP_num()));
		}
		return mapJson;
	}
}
