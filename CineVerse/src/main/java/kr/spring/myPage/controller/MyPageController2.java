package kr.spring.myPage.controller;

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

import kr.spring.member.vo.CouponVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.movie.vo.MovieBookingVO;
import kr.spring.myPage.service.MyPageService;
import kr.spring.myPage.service.MyPageService2;
import kr.spring.myPage.vo.AddressVO;
import kr.spring.myPage.vo.MyPageVO;
import kr.spring.shop.service.ShopService;
import kr.spring.shop.vo.OrdersVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MyPageController2 {
	@Autowired
	private ShopService shopService;

	@Autowired
	private MyPageService2 mypageService2;

	@Autowired
	private MyPageService mypageService;
	
	@ModelAttribute
	public AddressVO initCommand() {
		return new AddressVO();
	}
	 
	// 회원 정보 - 배송지 관리
	@GetMapping("/myPage/addressList")
	public String myPageAddressList(HttpSession session, Model model) {
	    log.debug("<<배송지 관리>> ::: 진입 성공");
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    MyPageVO member = mypageService.selectMember(user.getMem_num());
	    member.setCoupon_cnt(mypageService.selectMemberCoupon(user.getMem_num()));


	    Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("mem_num", user.getMem_num());
		int resCnt = mypageService.reservationCnt(map2);
		MovieBookingVO booking = mypageService.mainRes(user.getMem_num());
		if (booking != null && resCnt > 0) {
			member.setC_branch(booking.getC_branch());
			member.setM_name(booking.getM_name());
			member.setMt_start(booking.getMt_start());
			member.setMt_date(booking.getMt_date());
			member.setTh_name(booking.getTh_name());
		}
		model.addAttribute("resCnt", resCnt);
	    
	    
	    model.addAttribute("member", member);
	    
	    Integer count = mypageService2.countAddress(user.getMem_num());
	    List<AddressVO> addressList = mypageService2.addressList(user.getMem_num());
	    
	    model.addAttribute("count", count);
	    model.addAttribute("addressList", addressList);
	    model.addAttribute("address", new AddressVO());
	    return "addressList";
	}

	// 배송지 추가
	@PostMapping("/myPage/addressList")
	public String addAddress(@Valid AddressVO addressVO, BindingResult result, HttpServletRequest request, HttpSession session, Model model) throws IllegalStateException, IOException {
	    log.debug("<<배송지 추가>> ::: " + addressVO);

	    MemberVO user = (MemberVO) session.getAttribute("user");
	    
	    // 유효성 체크 결과 오류가 있으면 폼 호출
	    if (result.hasErrors()) {
	    	log.debug("<<유효성 체크 시작>>");
	    	
	    	 result.getFieldErrors().forEach(error -> {
	             log.debug("유효성 검사 오류: " + error.getField() + " - " + error.getDefaultMessage());
	         });
	        
            log.debug("<<유효성 체크 완료>>");
            return myPageAddressList(session, model);
	    }
	    
	    addressVO.setMem_num(user.getMem_num());
	    mypageService2.addAddress(addressVO);

	    model.addAttribute("message", "성공적으로 배송지가 추가되었습니다.");
	    model.addAttribute("url", request.getContextPath() + "/myPage/addressList");
	    return "common/resultAlert"; 
	}
	

	// 마이페이지 구매 내역 페이지로 가기
	@GetMapping("/myPage/bought")
	public String getMyPageBought(MemberVO memberVO,HttpSession session, Model model) {
		
		 MemberVO user = (MemberVO)session.getAttribute("user");
		    MyPageVO member = mypageService.selectMember(user.getMem_num());
		    log.debug("<<구매 페이지 : : : >>" + user.getMem_num());
		    model.addAttribute("member", member);
		    Map<String, Object> map2 = new HashMap<String, Object>();
			map2.put("mem_num", user.getMem_num());
			
			int resCnt = mypageService.reservationCnt(map2);
			MovieBookingVO booking = mypageService.mainRes(user.getMem_num());
			if (booking != null && resCnt > 0) {
				member.setC_branch(booking.getC_branch());
				member.setM_name(booking.getM_name());
				member.setMt_start(booking.getMt_start());
				member.setMt_date(booking.getMt_date());
				member.setTh_name(booking.getTh_name());
			}
			model.addAttribute("resCnt", resCnt);
			
		    int count = shopService.countOrders(user.getMem_num());

		    List<OrdersVO> orders = shopService.selectOrders(user.getMem_num());
		    List<OrdersVO> total_quantity = shopService.howManyQuantity(user.getMem_num());
		    List<OrdersVO> total_price = shopService.howMuch(user.getMem_num());
		    
		    for (OrdersVO order : orders) {
		        for (OrdersVO qty : total_quantity) {
		            if (order.getOrder_num() == qty.getOrder_num()) {
		                order.setTotal_quantity(qty.getTotal_quantity());
		                break;
		            }
		        }

		        for (OrdersVO price : total_price) {
		            if (order.getOrder_num() == price.getOrder_num()) {
		                order.setTotal_price(price.getTotal_price());
		                CouponVO coupon = shopService.usedCoupon(order.getOrder_num());
		                if(coupon!= null){
		                	order.setTotal_price(price.getTotal_price() - coupon.getCoupon_sale());
		                }

		                break;
		            }
		        }
		        
		    }


		    model.addAttribute("orders", orders);
		    model.addAttribute("count", count);

		    return "bought";
	}

	// 마이페이지 구매 내역 상세 페이지로 가기
	@GetMapping("/myPage/boughtDetail")
	public String getMyPageDetailBought(@RequestParam long order_num, MemberVO memberVO,HttpSession session, Model model) {
		log.debug("<<구매 내역 상세 페이지 : order_num>> ::: " + order_num);
		MemberVO user = (MemberVO)session.getAttribute("user");
		MyPageVO member = mypageService.selectMember(user.getMem_num());
		
		member.setCoupon_cnt(mypageService.selectMemberCoupon(user.getMem_num()));


	    Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("mem_num", user.getMem_num());
		int resCnt = mypageService.reservationCnt(map2);
		MovieBookingVO booking = mypageService.mainRes(user.getMem_num());
		if (booking != null && resCnt > 0) {
			member.setC_branch(booking.getC_branch());
			member.setM_name(booking.getM_name());
			member.setMt_start(booking.getMt_start());
			member.setMt_date(booking.getMt_date());
			member.setTh_name(booking.getTh_name());
		}
		model.addAttribute("resCnt", resCnt);
	    
	    
	    model.addAttribute("member", member);
			
		List<OrdersVO> orderDetail = shopService.orderDetailList(order_num);
		int order_price = shopService.orderPrice(order_num);
		OrdersVO order = shopService.selectOrder(order_num);
		CouponVO coupon = shopService.usedCoupon(order_num);
		int deli=0;
		
		if(order_price<50000) {
			order_price += 3000;
			deli = 3000;
		}
		
		int point_price = order_price;
		int coupon_price = 0;
		
		if(coupon != null) {
			coupon_price = coupon.getCoupon_sale();
			point_price -= coupon_price;
		}
		
		model.addAttribute("deli", deli);
		model.addAttribute("coupon_price", coupon_price);
		model.addAttribute("point_price", point_price);
		
		model.addAttribute("order", order);
		model.addAttribute("orderDetail", orderDetail);
		model.addAttribute("order_price", order_price);
		
		return "boughtDetail";
	}
}
