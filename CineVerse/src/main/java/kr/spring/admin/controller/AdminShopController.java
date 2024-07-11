package kr.spring.admin.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import kr.spring.board.vo.BoardVO;
import kr.spring.shop.service.ShopService;
import kr.spring.shop.vo.ProductVO;
import kr.spring.util.FileUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AdminShopController {

	@Autowired
	private ShopService shopService;

	//자바빈(VO) 초기화
	@ModelAttribute
	public ProductVO initCommand() {
		return new ProductVO();
	}

	/*==============================
	 * 벌스샵 관리
	 *==============================*/

	// 상품 등록 폼
	@GetMapping("/admin/adminShop")
	public String adminShop(){
		return "adminShop";
	}


	/*-----------------------------------------
	 *  상품 등록
	 ------------------------------------------*/
	@PostMapping("/admin/registerProduct")
	public String registerProduct(@Valid ProductVO product, BindingResult result, HttpServletRequest request, HttpSession session, Model model)throws IllegalStateException,IOException{
		log.debug("<<상품 등록>> : " + product);

		/*
		// 유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return "adminShop";
		}
		 */

		product.setP_filename(FileUtil.createFile(request, product.getP_upload()));
		// 상품 등록
		shopService.registerProduct(product);

		// 메세지 처리
		model.addAttribute("message", "성공적으로 상품이 등록되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/admin/adminShop");
		return "common/resultAlert";
	}

	// 배송 상태 관리
	@GetMapping("/admin/adminDelivery")
	public String adminDelivery(){
		return "adminDelivery";
	}
	// 배송지
	@GetMapping("/admin/adminAddress")
	public String adminAddress(){
		return "adminAddress";
	}
	// 상품문의
	@GetMapping("/admin/adminShopQna")
	public String adminShopQna(){
		return "adminShopQna";
	}
	// 상품후기
	@GetMapping("/admin/adminShopReview")
	public String adminShopReview(){
		return "adminShopReview";
	}


}
