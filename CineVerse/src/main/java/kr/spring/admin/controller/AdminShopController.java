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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ch.qos.logback.classic.pattern.LineOfCallerConverter;
import kr.spring.board.vo.BoardVO;
import kr.spring.shop.service.ShopService;
import kr.spring.shop.vo.OrdersVO;
import kr.spring.shop.vo.ProductVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
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


	// 상품 등록
	@PostMapping("/admin/registerProduct")
	public String registerProduct(@Valid ProductVO productVO, BindingResult result, HttpServletRequest request, HttpSession session, Model model)throws IllegalStateException,IOException{
		log.debug("<<상품 등록>> : " + productVO);


		// 유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return "adminShop";
		}

		productVO.setP_filename(FileUtil.createFile(request, productVO.getP_upload()));
		// 상품 등록
		shopService.registerProduct(productVO);

		// 메세지 처리
		model.addAttribute("message", "성공적으로 상품이 등록되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/admin/adminShop");
		return "common/resultAlert";
	}

	// 상품 목록 관리
	@GetMapping("/admin/adminProductList")
	public String shopMain(@RequestParam(defaultValue="1") int pageNum,
			String keyfield, String keyword, Model model, HttpServletRequest request) {
		String pCategoryParam = request.getParameter("p_category");
		Integer p_category = null;
		if (pCategoryParam != null && !pCategoryParam.equals("all") && !pCategoryParam.isEmpty()) {
			try {
				p_category = Integer.parseInt(pCategoryParam);
			} catch (NumberFormatException e) {
				System.out.println("Invalid p_category value: " + pCategoryParam);
			}
		}

		log.debug("<<관리자 - 상품 목록 p_category >> ::: " + p_category);

		Map<String, Object> map = new HashMap<>();
		map.put("p_category", p_category);
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		int count = shopService.productAllCount(map);

		PagingUtil page = new PagingUtil(keyfield, keyword, pageNum, count, 16, 10, "adminProductList", "&p_category=" + p_category);

		List<ProductVO> productList = null;

		if (count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			productList = shopService.adminProductList(map);
		}

		model.addAttribute("count", count);
		model.addAttribute("productList", productList);
		model.addAttribute("page", page.getPage());

		return "adminProductList";
	}

	@GetMapping("/admin/modifyProduct")
	public String modifyProductForm(@RequestParam Long p_num, Model model) {
		log.debug("<<관리자 - 상품 수정폼 p_num >> ::: " + p_num);

		ProductVO product = shopService.productDetail(p_num);
		product.setP_name(StringUtil.useNoHTML(product.getP_name()));
		model.addAttribute("productVO", product);

		return "adminModifyProduct";
	}


	@PostMapping("/admin/modifyProduct")
	public String modifyProduct(@Valid ProductVO productVO, BindingResult result, Model model, HttpServletRequest request) throws IllegalStateException, IOException {
		log.debug("<<관리자 - 상품 수정 productVO >> ::: " + productVO);

		if(result.hasErrors()) {
			// 상품 수정 폼으로 돌아가기
			ProductVO vo = shopService.productDetail(productVO.getP_num());
			productVO.setP_filename(vo.getP_filename());
			return "adminModifyProduct";
		}

		// 기존 상품 정보 가져오기
		ProductVO db_product = shopService.productDetail(productVO.getP_num());

		// p_upload가 null이거나 비어있지 않다면 새 파일 생성
		if (productVO.getP_upload() != null && !productVO.getP_upload().isEmpty()) {
			// 새 파일 생성
			productVO.setP_filename(FileUtil.createFile(request, productVO.getP_upload()));

			// 기존 파일 삭제
			FileUtil.removeFile(request, db_product.getP_filename());
		} else {
			// 기존 파일명 유지
			productVO.setP_filename(db_product.getP_filename());
		}

		// 상품 정보 업데이트
		shopService.updateProduct(productVO);

		// 성공 메시지와 URL 추가
		model.addAttribute("message", "상품 정보 수정 완료!!");
		model.addAttribute("url", request.getContextPath() + "/admin/adminProductList");

		return "common/resultAlert";
	}

	// 배송 상태 관리
	@GetMapping("/admin/adminDelivery")
	public String adminDelivery(@RequestParam(defaultValue="1") int pageNum,
			String keyfield, String keyword, Model model, HttpServletRequest request){
		log.debug("<<관리자 - 주문 목록>> ");

		Map<String, Object> map = new HashMap<>();

		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		int count = shopService.orderCount(map);

		PagingUtil page = new PagingUtil(keyfield, keyword, pageNum, count, 16, 10, "adminDelivery");

		List<OrdersVO> orderList = null;

		if (count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			orderList = shopService.orderList(map);
		}

		model.addAttribute("count", count);
		model.addAttribute("orderList", orderList);
		model.addAttribute("page", page.getPage());
		return "adminDelivery";
	}

	@GetMapping("/admin/adminOrderDetail")
	public String adminOrderDetail(@RequestParam Long order_num, Model model) {
		log.debug("<<관리자 - 주문 내역>> ::: " + order_num);

		List<OrdersVO> orderDetailList = shopService.adminOrderDetailList(order_num);
		OrdersVO ordersVO = shopService.adminOrders(order_num);
		model.addAttribute("ordersVO", ordersVO);
		model.addAttribute("order_num", order_num);
		model.addAttribute("orderDetailList", orderDetailList);
		return "adminOrderDetail";
	}

	@GetMapping("/admin/adminOrderAddress")
	public String adminOrderAddress(@RequestParam Long a_num, Long order_num,Model model) {
		log.debug("<<관리자 - 주문 배송지>>");

		OrdersVO address = shopService.selectOrderAddress(a_num);
		List<OrdersVO> addressList = shopService.selectMemAddress(address.getMem_num());
		model.addAttribute("addressList", addressList);
		model.addAttribute("address", address);
		model.addAttribute("order_num", order_num);
		return "adminOrderAddress";
	}

	@PostMapping("/admin/modifyOrderAddress")
	public String modifyOrderAddress(@RequestParam String aNum, @RequestParam Long order_num, HttpServletRequest request, Model model) {

		log.debug("<<배송지 변경 >> ::: " + aNum);
		Long a_num = Long.parseLong(aNum);

		shopService.updateOrderAddress(a_num, order_num);


		model.addAttribute("message", "성공적으로 주문 상태가 변경되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/admin/adminOrderAddress?a_num=" + a_num +"&order_num=" + order_num);
		return "common/resultAlert";
	}

	@PostMapping("/admin/modifyDelivery")
	public String adminModifyDelivery(OrdersVO orders, Model model, HttpServletRequest request) {
		shopService.updateOrderStatus(orders.getOrder_status(), orders.getOrder_num());
		List<OrdersVO> orderDetailList = shopService.adminOrderDetailList(orders.getOrder_num());
		OrdersVO ordersVO = shopService.adminOrders(orders.getOrder_num());
		model.addAttribute("ordersVO", ordersVO);
		model.addAttribute("order_num", ordersVO.getOrder_num());
		model.addAttribute("orderDetailList", orderDetailList);

		model.addAttribute("message", "성공적으로 주문 상태가 변경되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/admin/adminOrderDetail?order_num=" + ordersVO.getOrder_num());
		return "common/resultAlert";
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
	public String adminShopReview(@RequestParam(defaultValue="1") int pageNum,
			String keyfield, String keyword, Model model, HttpServletRequest request){
		log.debug("<<관리자 - 후기 목록>> ");

		Map<String, Object> map = new HashMap<>();

		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		int count = shopService.adminReviewCount(map);

		PagingUtil page = new PagingUtil(keyfield, keyword, pageNum, count, 16, 10, "adminShopReview");

		List<ProductVO> reviewList = null;

		if (count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			reviewList = shopService.selectReviewList(map);
		}

		model.addAttribute("count", count);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("page", page.getPage());
		
		return "adminReview";
	}
	
	
	


}
