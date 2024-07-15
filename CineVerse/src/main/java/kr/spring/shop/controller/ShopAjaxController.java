package kr.spring.shop.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
import kr.spring.shop.vo.PBasketVO;
import kr.spring.shop.vo.ProductVO;
import lombok.extern.slf4j.Slf4j;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
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
				shopService.directOrderDetail(orders);

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
	public Map<String, Object> basketDelete(@RequestParam long pb_num, @RequestParam long mem_num, HttpSession session) {
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

	// 장바구니 삭제하기
	@PostMapping("/shop/basketUpdate")
	@ResponseBody
	public Map<String, Object> basketUpdate(@RequestParam long pb_num, @RequestParam long mem_num, @RequestParam long updateNum,HttpSession session) {
		log.debug("<<장바구니 수량 변경 - pb_num>> ::: " + pb_num);
		log.debug("<<장바구니 수량 변경 - updateNum>> ::: " + updateNum);
		Map<String, Object> mapJson = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("user");

		PBasketVO basket = shopService.selectBasket(pb_num);
		long remain = shopService.productRemain(basket.getP_num());


		if (user == null) { // 로그아웃 상태
			mapJson.put("result", "logout");
		} else if(user.getMem_num()!=mem_num) {
			mapJson.put("result", "wrongAccess");
		} else if(remain<updateNum) { // 재고 부족
			mapJson.put("result", "noProduct");
		} else {
			long pb_quantity = updateNum;
			shopService.basketUpdate(pb_num, pb_quantity);
			mapJson.put("result", "success");
		}
		return mapJson;
	}

	// 장바구니 체크 
	@PostMapping("/shop/updateBasketNav")
	@ResponseBody
	public Map<String, Object> yesnoBasket(@RequestParam long p_price, @RequestParam long pb_quantity, @RequestParam long now_total, @RequestParam long now_pb_quantity, @RequestParam long mem_num, HttpSession session){
		log.debug("<<장바구니 체크 - p_price>> ::: " + p_price);
		log.debug("<<장바구니 체크 - pb_quantiy>> ::: " + pb_quantity);
		log.debug("<<장바구니 체크 - now_pb_quantiy>> ::: " + now_pb_quantity);
		log.debug("<<장바구니 체크 - now_total>> ::: " + now_total);

		Map<String, Object> mapJson = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("user");

		if (user == null) { // 로그아웃 상태
			mapJson.put("result", "logout");
		} else if(user.getMem_num()!=mem_num) {
			mapJson.put("result", "wrongAccess");
		} else {
			mapJson.put("result", "success");
		}
		return mapJson;
	}

	// 장바구니 -> 결제 -> 진짜 결제하기
	@PostMapping("/shop/buyWithBasket")
	@ResponseBody
	public Map<String, Object> postMethodName(@RequestParam Map<String, String> formData, HttpSession session) {
	    log.debug("<<장바구니에서 결제하기>> ::: " + formData);

	    String countStr = formData.get("count");
	    int count;
	    count = Integer.parseInt(countStr.replace(",", ""));

	    List<Integer> pb_nums = new ArrayList<>();

	    for (int i = 1; i <= count; i++) {
	        String pb_numStr = formData.get("pb_num" + i);
	        pb_nums.add(Integer.parseInt(pb_numStr.replace(",", "")));
	    }

	    Map<String, Object> mapJson = new HashMap<String, Object>();
	    MemberVO user = (MemberVO) session.getAttribute("user");

	    String anumStr = formData.get("a_num");
	    long a_num = Integer.parseInt(anumStr.replace(",", ""));
	    
	    String agreeStr = formData.get("agree");
	    long agree = Integer.parseInt(agreeStr.replace(",", ""));
	    
	    String mc_numStr = formData.get("mc_num");
	    long mc_num = Integer.parseInt(mc_numStr.replace(",", ""));
	    
	    String totalStr = formData.get("total");
	    long total = Integer.parseInt(totalStr.replace(",", ""));
	    if (total<50000) {
	    	total+=3000;
	    }
	    String total_countStr = formData.get("total_count");
	    long total_count = Integer.parseInt(total_countStr.replace(",", ""));
	    
	    if (user == null) { // 로그아웃 상태
	        mapJson.put("result", "logout");
	    } else if (a_num == 0) { // 배송지 없음
	        mapJson.put("result", "noAddress");
	    } else if (agree == 2) { // 동의 x
	        mapJson.put("result", "noAgree");
	    } else {
	        long point = shopService.getPoint(user.getMem_num());
	        log.debug("point ::: " + point);
	        if (point < total) { // 포인트 부족
	            mapJson.put("result", "noPoint");
	        } else { // 성공
	            OrdersVO orders = new OrdersVO();
	            orders.setMem_num(user.getMem_num());
	            orders.setA_num(a_num);

	            // 주문번호(사용자에게 보여줄 용도. PK 아님) 생성
	            LocalDate today = LocalDate.now();
	            int year = today.getYear();
	            int month = today.getMonthValue();
	            int day = today.getDayOfMonth();
	            String od_number;
	            if (month < 10) {
	                od_number = year + ("-0" + month) + day;
	            } else {
	                od_number = year + ("-" + month) + day;
	            }

	            Random random = new Random();
	            String ran_num_result = "-";
	            for (int i = 0; i < 4; i++) {
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

	            // 주문 상품들 내역에 추가
	            OrdersVO order_detail = new OrdersVO();
	            // 모든 상세 내역 공통 주문 번호 
	            order_detail.setOrder_num(order_num);
	            
	            for (int i = 0; i < count; i++) {
	                int pb_num = pb_nums.get(i);
	                PBasketVO basket = shopService.selectBasket(pb_num);
	                order_detail.setOrder_quantity(basket.getPb_quantity());
	                order_detail.setP_num(basket.getP_num());
	                shopService.directOrderDetail(order_detail); // 내역 추가
	                shopService.sellProduct(basket.getPb_quantity(), basket.getP_num()); // 상품 수량 차감
	                shopService.basketDelete(pb_num); // 장바구니에서 삭제
	            }

	            // 포인트 차감
	            orders.setPh_point(total);
	            orders.setPh_type(1); // 사용
	            shopService.usePoint(orders);

	            // 포인트 갱신 
	            memberService.totalPoint(user.getMem_num());

	            if (mc_num != 0) { // 쿠폰 사용했을 경우
	                shopService.useCoupon(orders.getMc_num());
	            }

	            mapJson.put("result", "success");
	        }
	    }

	    return mapJson;
	}


}
