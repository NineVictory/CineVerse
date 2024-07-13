package kr.spring.shop.controller;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.CouponVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.myPage.dao.MyPageMapper;
import kr.spring.myPage.service.MyPageService;
import kr.spring.shop.dao.ShopMapper;
import kr.spring.shop.service.ShopService;
import kr.spring.shop.vo.OrdersVO;
import kr.spring.shop.vo.ProductVO;
import lombok.extern.slf4j.Slf4j;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestParam;



@Slf4j
@Controller
public class ShopAjaxController {
	@Autowired
	private ShopService shopService;

	@Autowired
	private MemberService memberService;

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

	// 쿠폰 선택하기
	@GetMapping("/shop/coupon")
	@ResponseBody
	public Map<String, Object> getMethodName(@RequestParam long mc_num, @RequestParam long sale, @RequestParam long noSaleTotal, HttpSession session) {
		log.debug("<<쿠폰 선택 - mc_num>> ::: " + mc_num);
		log.debug("<<쿠폰 선택 - sale>> ::: " + sale);
		log.debug("<<쿠폰 선택 - noSaleTotal(배송비, 쿠폰 적용 전)>> ::: " + noSaleTotal);
		Map<String, Object> mapJson = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		CouponVO coupon = shopService.couponInfo(mc_num);


		long deli = 0;
		if(noSaleTotal<50000) {
			deli =3000;
		}

		// 쿠폰 쓰기 위한 최소 금액 -> coupon_db에 추가해야 함 -> else if 하나 더 추가 해야 함
		if(user==null) {
			mapJson.put("result", "logout");
		} else if((noSaleTotal+deli-sale)<0) { // 쿠폰 할인 했더니 마이너스 되는 경우
			mapJson.put("result", "minus");
		} else {
			mapJson.put("result", "success");
		}
		return mapJson;
	}

	// 바로 구매하기
	@PostMapping("/shop/buyDirect")
	@ResponseBody
	public Map<String, Object> buyDirect(@ModelAttribute OrdersVO orders, HttpSession session, Model model) {
		log.debug("<<상품 바로 구매>> ::: " + orders);

		Map<String, Object> mapJson = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("user");

		if (user == null) { // 로그아웃 상태
			mapJson.put("result", "logout");
		} else if (orders.getA_num() == 0) { // 배송지 없음
			mapJson.put("result", "noAddress");
		} else if(orders.getAgree()==2) { // 동의 x
			mapJson.put("result", "noAgree");
		} else {
			long point = shopService.getPoint(user.getMem_num());
			if(point<orders.getTotal()) { // 포인트 부족
				mapJson.put("result", "noPoint");
			} else { // 성공
				// order, order_detail 추가
				orders.setMem_num(user.getMem_num());
				orders.setOrder_quantity(orders.getPb_quantity());
				
				// 주문번호(사용자에게 보여줄 용도. PK 아님) 생성
				// 약간... 간지 느낌
				// 형식 : yyyy-mmdd-랜덤숫자-주문번호(PK)
				LocalDate today = LocalDate.now();
				
				int year = today.getYear();
				int month = today.getMonthValue();
				int day = today.getDayOfMonth();
				String od_number;
				if(month<10) {
					od_number = year + ("-0"  + month) + day;
				} else {
					od_number = year + ("-"  + month) + day;
				}
				
				
				Random random = new Random();
				
				String ran_num_result = "-";
				for(int i=0; i<4; i++) {
					int ran_num = random.nextInt(10);
					ran_num_result += ran_num;
				}
				
				// 주문 번호 (PK) 설정
				long order_num = shopService.getNextOrderNum();
				orders.setOrder_num(order_num);
				
				// 주문 번호 (간지용) 설정
				od_number = od_number + ran_num_result + "-" + order_num;
				orders.setOd_number(od_number);
				
				shopService.directOrder(orders);

				// 상품 수량 차감
				shopService.sellProduct(orders.getPb_quantity(), orders.getP_num());

				// 포인트 차감
				orders.setPh_point(orders.getTotal());
				orders.setPh_type(1); // 사용
				shopService.usePoint(orders);

				// 포인트 갱신 
				memberService.totalPoint(user.getMem_num());

				if(orders.getMc_num()!=0) { // 쿠폰 사용했을 경우
					shopService.useCoupon(orders.getMc_num());
				}

				mapJson.put("result", "success");
			}
		}
		return mapJson;
	}


	/* 왜 이건 안 됐던걸까
	 * if(mc_num!=0) { shopService.useCoupon(mc_num); } MemberVO user =
	 * (MemberVO)session.getAttribute("user");
	 * 
	 * OrdersVO orders = new OrdersVO(); orders.setMem_num(user.getMem_num());
	 * orders.setA_num(2);
	 * 
	 * orders.setOrder_quantity(pb_quantity); orders.setP_num(p_num);
	 * 
	 * shopService.directOrder(orders);
	 * 
	 * orders.setPh_point(total);
	 * 
	 * 
	 * shopService.usePoint(orders); shopService.sellProduct(pb_quantity, p_num);
	 * 
	 * 
	 */

	// 장바구니 삭제하기
	@PostMapping("/shop/basketDelete")
	@ResponseBody
	public Map<String, Object> getMethodName(@RequestParam long pb_num, @RequestParam long mem_num, HttpSession session) {
		log.debug("<<장바구니 삭제>> ::: " + pb_num);
		Map<String, Object> mapJson = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("user");

		if (user == null) { // 로그아웃 상태
			mapJson.put("result", "logout");
		} else if(user.getMem_num()!=mem_num) {
			mapJson.put("result", "wrongAccess");
		} else {
			shopService.basketDelete(pb_num);
			mapJson.put("result", "success");
		}
		return mapJson;
	}




}
