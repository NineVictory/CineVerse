package kr.spring.shop.controller;

import java.net.http.HttpRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.vo.MemberVO;
import kr.spring.myPage.service.MyPageService;
import kr.spring.myPage.service.MyPageService2;
import kr.spring.myPage.vo.AddressVO;
import kr.spring.myPage.vo.MyPageVO;
import kr.spring.shop.service.ShopService;
import kr.spring.shop.vo.OrdersVO;
import kr.spring.shop.vo.PBasketVO;
import kr.spring.shop.vo.ProductVO;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;


@Slf4j
@Controller
public class ShopController {

	@Autowired
	private ShopService shopService;

	@Autowired
	public MyPageService2 mypageService2;
	
	@Autowired
	public MyPageService mypageService;
	
	// 벌스샵 메인 (목록)
	@GetMapping("/shop/shopMain")
	public String shopMain(@RequestParam(defaultValue="1") int pageNum,
			@RequestParam(defaultValue="1") int shopOrder,
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

		log.debug("<<벌스샵 메인>> - p_category: " + p_category);
		log.debug("<<벌스샵 메인>> - shopOrder: " + shopOrder);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("p_category", p_category);
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		int count = shopService.productCount(map);

		PagingUtil page = new PagingUtil(keyfield, keyword, pageNum, count, 16, 10, "shopMain", "&p_category=" + p_category + "&shopOrder=" + shopOrder);

		List<ProductVO> productList = null;
		if (count > 0) {
			map.put("shopOrder", shopOrder);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			productList = shopService.productList(map);
		}

		model.addAttribute("count", count);
		model.addAttribute("productList", productList);
		model.addAttribute("page", page.getPage());

		return "shopMain";
	}

	// 벌스샵 상세 (상품 상세)
	@GetMapping("/shop/shopDetail")
	public ModelAndView shopDetail(long p_num) {
		log.debug("<<벌스샵 상세 - p_num>> ::: " + p_num);

		ProductVO product = shopService.productDetail(p_num);
		product.setP_name(StringUtil.useNoHTML(product.getP_name()));

		return new ModelAndView("shopDetail", "product", product);
	}

	// 벌스샵 결제 (상품 결제) - 바로 가기
	@PostMapping("/shop/buyNow")
	public String shopBuy(@RequestParam("p_num") long p_num, @RequestParam("pb_quantity") long pb_quantity, HttpSession session, Model model, HttpServletRequest request) {
		log.debug("<<벌스샵 결제 - p_num>> ::: " + p_num);
		log.debug("<<벌스샵 결제 - pb_quantity>> ::: " + pb_quantity);
		
		// 구매하고자 하는 상품 상세 정보
		ProductVO product = shopService.productDetail(p_num);
		product.setP_name(StringUtil.useNoHTML(product.getP_name()));
		model.addAttribute("product", product);
		
		// 상품 수량
		model.addAttribute("pb_quantity", pb_quantity);
		
		// 배송지 정보
		MemberVO user = (MemberVO)session.getAttribute("user");
		List<AddressVO> address = mypageService2.addressList(user.getMem_num());
		Integer count = mypageService2.countAddress(user.getMem_num());
		model.addAttribute("count", count);
		model.addAttribute("address", address);
		
		// 보유 쿠폰 정보
		Map<String,Object> map = new HashMap<String,Object>();
		List<MyPageVO> couponList = null;
		map.put("mem_num", user.getMem_num());
		MyPageVO member = mypageService.selectMember(user.getMem_num());
		member.setCoupon_cnt(mypageService.selectMemberCoupon(user.getMem_num()));//복붙
		if(member.getCoupon_cnt() > 0) {
			couponList = mypageService.selectMemCouponList(map);
		}
		model.addAttribute("couponList",couponList);
		model.addAttribute("member",member);
		
		return "shopBuy";
	}


	// 벌스샵 장바구니 (상품 장바구니) 불러오기
	@GetMapping("/shop/shopBasket")
	public ModelAndView shopMyBasket(HttpSession session, Model model) {
		log.debug("<<장바구니 진입>> ::: 성공");
		List<ProductVO> list = null;
		MemberVO user = (MemberVO)session.getAttribute("user");
		list = shopService.productBasketList(user.getMem_num());

		Integer count=shopService.basketCount(user.getMem_num());
		/* List<Integer> price = shopService.basketPrice(user.getMem_num()); */
		Integer total = shopService.basketTotalPrice(user.getMem_num());
		Map<String, Object> map = new HashMap<>();
		/* map.put("price", price); */
		map.put("total", total);
		map.put("list", list);
		map.put("count", count);

		return new ModelAndView("shopBasket", map);
	}

	// 벌스샵 장바구니 담기
	@PostMapping("/shop/addToCart")
	public String addToCart(@RequestParam("p_num") long p_num, @RequestParam("pb_quantity") long pb_quantity, HttpSession session, Model model, HttpServletRequest request) {
		log.debug("<<장바구니 담기 p_num>> ::: " + p_num);
		log.debug("<<장바구니 담기 pb_quantity>> ::: " + pb_quantity);

		MemberVO user = (MemberVO) session.getAttribute("user");

		PBasketVO basket = new PBasketVO();
		basket.setMem_num(user.getMem_num());
		basket.setP_num(p_num);

		PBasketVO userBasket = shopService.selectProductBasket(basket);

		// 장바구니에 이미 상품이 있는 경우
		if (userBasket != null) {
			model.addAttribute("message", "이미 장바구니에 담겨 있습니다.");
			model.addAttribute("url", request.getContextPath() + "/shop/shopDetail?p_num=" + p_num);
			return "common/resultAlert";
		}

		// 장바구니에 담을 상품 정보
		userBasket = new PBasketVO();
		userBasket.setMem_num(user.getMem_num());
		userBasket.setP_num(p_num);
		userBasket.setPb_quantity(pb_quantity);

		// 장바구니 상품을 등록
		shopService.ProductBasket(userBasket);

		model.addAttribute("message", "장바구니에 담았습니다.");
		model.addAttribute("url", request.getContextPath() + "/shop/shopBasket");
		return "common/resultAlert";
	}

	// 벌스샵 관심 상품 목록
	@GetMapping("/shop/shopFav")
	public ModelAndView shopFav(HttpSession session, Model model) {
		log.debug("<<관심 상품 목록 진입>> ::: 성공");
		List<ProductVO> list = null;
		MemberVO user = (MemberVO)session.getAttribute("user");
		list = shopService.productFavList(user.getMem_num());

		Map<String, Object> map = new HashMap<>();
		map.put("list", list);

		return new ModelAndView("shopFav", map);
	}

}
