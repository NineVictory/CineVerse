package kr.spring.myPage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.assignment.service.AssignService;
import kr.spring.assignment.vo.AssignFavVO;
import kr.spring.assignment.vo.AssignVO;
import kr.spring.board.service.BoardService;
import kr.spring.board.vo.BoardBookmarkVO;
import kr.spring.board.vo.BoardFavVO;
import kr.spring.board.vo.BoardVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.CouponVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.movie.service.MovieService;
import kr.spring.movie.vo.MovieBookMarkVO;
import kr.spring.movie.vo.MovieBookingVO;
import kr.spring.myPage.service.MyPageService;
import kr.spring.myPage.service.MyPageService2;
import kr.spring.myPage.vo.AddressVO;
import kr.spring.myPage.vo.MyPageVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MyPageAjaxController {
	@Autowired
	MyPageService mypageService;

	@Autowired
	MyPageService2 mypageService2;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	AssignService assignService;
	
	@Autowired
	MovieService movieService;
	
	@Autowired
	MemberService memberService;
	
	@PostMapping("/myPage/updateMyPhoto")
	@ResponseBody
	public Map<String, String> processProfile(MyPageVO myPageVO, HttpSession session) {
		Map<String, String> mapAjax = new HashMap<>();
		MemberVO user = (MemberVO) session.getAttribute("user");
		if (user == null) {
			mapAjax.put("result", "logout");
		} else {
			myPageVO.setMem_num(user.getMem_num());
			mypageService.updateProfile(myPageVO);

			// 세션에 업데이트된 프로필 사진 저장
			user.setPhoto(myPageVO.getPhoto());
			user.setPhoto_name(myPageVO.getPhoto_name());
			session.setAttribute("user", user);

			log.debug("<< 프로필 사진 업데이트 성공 >> : " + user.getPhoto_name());

			mapAjax.put("result", "success");
		}

		return mapAjax;
	}

	
	//배송지 삭제
	@PostMapping("/myPage/deleteAddress")
	@ResponseBody
	public Map<String, Object> deleteAddress(long a_num, HttpSession session) {
	    log.debug("<<배송지 삭제 - a_num>> : " + a_num);
	    Map<String, Object> mapJson = new HashMap<String, Object>();
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    AddressVO address = mypageService2.selectOrder(a_num);
	    if (user == null) {
	        mapJson.put("result", "logout");
	    } else if(address != null){
	    	mypageService2.updateAddressStatus(a_num);
	    	mapJson.put("result", "success");
	    } else {
	    	mypageService2.deleteAddress(a_num);
	    	mapJson.put("result", "success");
	    }
	    
	    return mapJson;
	}
	
	
	//양도/교환 북마크 삭제
	@PostMapping("/myPage/deleteABoardBookMark")
	@ResponseBody
	public Map<String, Object> deleteABoardBookMark(long ab_num,long mem_num,HttpSession session){
		log.debug("<<양도/교환 북마크 삭제 - ab_num>> : " + ab_num);
		Map<String, Object> mapJson = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(user == null) {
			mapJson.put("result", "logout");
		}else if(user.getMem_num() != mem_num) {
			mapJson.put("result", "wrongAccess");
		}else{
			// AssignFavVO 객체 생성 및 설정
	        AssignFavVO fav = new AssignFavVO();
	        fav.setAb_num(ab_num);
	        fav.setMem_num(mem_num);
			
	        assignService.ab_deleteFav(fav);
			mapJson.put("result", "success");
		}
		return mapJson;
	}
	
	//게시글 북마크
	@PostMapping("/myPage/deleteCBoardBookMark")
	@ResponseBody
	public Map<String, Object> deleteCBoardBookMark(BoardBookmarkVO board,HttpSession session){
		log.debug("<<커뮤니티 북마크 삭제>> : " + board.getCb_num() + ", mem_num: " + board.getMem_num());
		Map<String, Object> mapJson = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(user == null) {
			mapJson.put("result", "logout");
		}else if(user.getMem_num() != board.getMem_num()) {
			mapJson.put("result", "wrongAccess");
		}else {
			boardService.deleteBM(board);
			mapJson.put("result", "success");
		}
		return mapJson;
	}
	
	//게시글 좋아요
	@PostMapping("/myPage/deleteCboardFav")
	@ResponseBody
	public Map<String, Object> deleteCBoardFav(BoardFavVO board, HttpSession session) {
	    log.debug("<<커뮤니티 좋아요 삭제>> : " + board.getCb_num() + ", mem_num: " + board.getMem_num());
	    Map<String, Object> mapJson = new HashMap<String, Object>();
	    MemberVO user = (MemberVO) session.getAttribute("user");

	    if (user == null) {
	        mapJson.put("result", "logout");
	    } else if (user.getMem_num() != board.getMem_num()) {
	        mapJson.put("result", "wrongAccess");
	    } else {
	    	//board.setMem_num(user.getMem_num());
	        boardService.deleteFav(board);
	        mapJson.put("result", "success");
	    }
	    return mapJson;
	}


	//기대되는 영화
	@PostMapping("/myPage/deleteMovieBookMark")
	@ResponseBody
	public Map<String, Object> deleteMovieBookMark(MovieBookMarkVO bookMark,HttpSession session){
		log.debug("<<찜영화 삭제 - m_code>> : " + bookMark.getM_code());
		Map<String, Object> mapJson = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(user==null) {
			mapJson.put("result", "logout");
		}else if(user.getMem_num()!=bookMark.getMem_num()) {
			mapJson.put("result", "wrongAccess");
		}else {
			movieService.deleteBookMark(bookMark);
			mapJson.put("result", "success");
		}
		return mapJson;
	}
	
	//멤버십 구독
	@PostMapping("/myPage/subMembership")
	@ResponseBody
	public Map<String, Object> subMembership(@RequestParam Long mem_num,MyPageVO mypage,HttpSession session){
		log.debug("<<멤버십 구독>> : " +mem_num);
		Map<String, Object> mapJson = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(user==null) {
			mapJson.put("result", "logout");
		}else {
			
			MyPageVO member = mypageService.selectMember(user.getMem_num());
			int point = member.getPoint();
			if(point < 10000) {
				mapJson.put("result", "noPoint");
			}else {
				//구독 멤버십 상태 업데이트
				mypageService.updateMembership(user.getMem_num());
				//멤버십 내역 히스토리
				mypageService.insertMembership(user.getMem_num());
				
				// 초기 쿠폰 리스트 조회
		        List<Long> initialCoupons = mypageService.selectInitialCoupons();
		        
		        //멤버쿠폰에 디비에있는 쿠폰을 불러서 삽입
		        for (Long coupon_num : initialCoupons) {
		        	CouponVO coupon = new CouponVO();
		            coupon.setMem_num(mypage.getMem_num());
		            coupon.setCoupon_num(coupon_num);
		            log.debug("Inserting coupon: " + coupon); 
		            mypageService.insertNewMemCoupon(coupon);
		        }
				
				//포인트 절감(포인트 히스토리)
				mypageService.usePoint(user.getMem_num());
				//포인트 갱신
				memberService.totalPoint(user.getMem_num());
				
				mapJson.put("result", "success");
			}
			 
		}
		return mapJson;
	}
	
	//예매취소
	@PostMapping("/myPage/deleteRes")
	@ResponseBody
	public Map<String, Object> deleteRes(MovieBookingVO booking,HttpSession session){
		MemberVO user = (MemberVO)session.getAttribute("user");
		Map<String, Object> mapJson = new HashMap<String, Object>();
		if(user == null) {
			mapJson.put("result", "logout");
		}else if(user.getMem_num()!=booking.getMem_num()) {
			mapJson.put("result", "wrongAccess");
		}else {
			//쿠폰 use 변경2->1(미사용)
			mypageService.updateCoupon(user.getMem_num());
			//포인트 환불(포인트 히스토리)
			mypageService.updatePoint(user.getMem_num());
			//포인트 갱신
			memberService.totalPoint(user.getMem_num());
			
			mapJson.put("result", "success");
		}
		return mapJson;
	}
	
	
	
	
	//게시글 삭제
	@PostMapping("/myPage/deleteCBoard")
	@ResponseBody
	public Map<String, Object> deleteCBoard(Long cb_num,Long mem_num,HttpSession session){
		log.debug("<<게시글 삭제>> : " +cb_num);
		Map<String, Object> mapJson = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "logout");
		}else if(user != null && user.getMem_num() == mem_num) {
			boardService.deleteBoard(cb_num);	
			mapJson.put("result", "success");
		}else {
			mapJson.put("result", "wrongAccess");
		}
		return mapJson;
	}
	
	//게시글 댓글
	@PostMapping("/myPage/deleteCBoardResponse")
	@ResponseBody
	public Map<String, Object> deleteCBoardResponse(Long cc_num, Long te_num, Long mem_num, HttpSession session) {
	    log.debug("<<댓글 삭제>> : " + cc_num);
	    log.debug("<<답글 삭제>> : " + te_num);
	    Map<String, Object> mapJson = new HashMap<>();
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    if (user == null) {
	        mapJson.put("result", "logout");
	    } else if (user != null && user.getMem_num()==mem_num) {
	        if (te_num != null && cc_num == null) {
	            boardService.deleteResponse(te_num);
	        }
	        else if (cc_num != null && te_num == null) {
	            boardService.deleteComment(cc_num);
	        }
	        else  {//(cc_num != null && te_num != null)
	        	boardService.deleteResponse(te_num);
	            boardService.deleteComment(cc_num);
	        }
	        mapJson.put("result", "success");
	    } else {
	        mapJson.put("result", "wrongAccess");
	    }
	    return mapJson;
	}

	//양도 게시글 삭제
	@PostMapping("/myPage/deleteAboardWrite")
	@ResponseBody
	public Map<String, Object> deleteAboardWrite(Long ab_num,Long mem_num,HttpSession session){
		log.debug("<<게시글 삭제>> : " +ab_num);
		
		Map<String, Object> mapJson = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(user==null) {
			mapJson.put("result", "logout");
		}else if(user.getMem_num() != mem_num) {
			mapJson.put("result", "wrongAccess");
		}else {
			assignService.ab_deleteBoard(ab_num);
			mapJson.put("result", "success");
		}
		
		return mapJson;
	}
	
	//리뷰 삭제
	@PostMapping("/myPage/deleteReview")
	@ResponseBody
	public Map<String, Object> deleteReview(Long mr_num,Long mem_num,HttpSession session){
		log.debug("<<리뷰 삭제>> : " + mr_num);
		
		Map<String, Object> mapJson = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(user==null) {
			mapJson.put("result", "logout");
		}else if(user.getMem_num()!= mem_num) {
			mapJson.put("result", "wrongAccess");
		}else {
			movieService.deleteReview(mr_num);
			mapJson.put("result", "success");
		}
		return mapJson;
	}
		
	
	
	
}
