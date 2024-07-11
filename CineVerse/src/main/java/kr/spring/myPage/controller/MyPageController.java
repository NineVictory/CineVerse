package kr.spring.myPage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.spring.board.vo.BoardVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.myPage.service.MyPageService;
import kr.spring.myPage.vo.MyPageVO;
import kr.spring.util.FileUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestParam;


@Slf4j
@Controller
public class MyPageController {
	@Autowired
	public MyPageService mypageService;
	//메인 페이지
	@GetMapping("/myPage/myPageMain")
	public String myPageMain(HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MyPageVO member = mypageService.selectMember(user.getMem_num());
		member.setCoupon_cnt(mypageService.selectMemberCoupon(user.getMem_num()));//복붙
		log.debug("<<마이페이지 >> : " +member);
		model.addAttribute("member",member);
		return "myPageMain";
	}
	
	
	//나의 예매내역
	@GetMapping("/myPage/reservation")
	public String myPageReservation(HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MyPageVO member = mypageService.selectMember(user.getMem_num());
		model.addAttribute("member",member);
		return "myPageReservation";
	}
	
	
	//나의 쿠폰
	@GetMapping("/myPage/coupon")
	public String myPageCoupon(HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MyPageVO member = mypageService.selectMember(user.getMem_num());
		member.setCoupon_cnt(mypageService.selectMemberCoupon(user.getMem_num()));//복붙
		
		// 쿠폰 리스트 불러오기 시작
		Map<String,Object> map = new HashMap<String,Object>();
		// mem_num 지정하기
		map.put("mem_num", user.getMem_num());
		 
		log.debug("<< 쿠폰 개수 >> : " + member.getCoupon_cnt());
		
		List<MyPageVO> couponList = null;
		// 쿠폰 개수 0보다 크면 list에 삽입
		if(member.getCoupon_cnt() > 0) {
			couponList = mypageService.selectMemCouponList(map);
		}
		
		model.addAttribute("couponList",couponList);
		model.addAttribute("member",member);
		
		return "coupon";
	}
	
	
	//나의 활동 - 기대되는 영화
	@GetMapping("/myPage/expectingMovie")
	public String expectingMovie(HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MyPageVO member = mypageService.selectMember(user.getMem_num());
		model.addAttribute("member",member);
		return "expectingMovie";
	}
	
	
	//나의 활동 - 내가 본 영화
	@GetMapping("/myPage/watchedMovie")
	public String watchedMovie(HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MyPageVO member = mypageService.selectMember(user.getMem_num());
		model.addAttribute("member",member);
		return "watchedMovie";
	}
	
	
	//나의 활동 - 내가 쓴 별점
	@GetMapping("/myPage/review")
		public String myPageReview(HttpSession session, Model model) {
			MemberVO user = (MemberVO)session.getAttribute("user");
			MyPageVO member = mypageService.selectMember(user.getMem_num());
			model.addAttribute("member",member);
			return "review";
		}
	
	
	//북마크
	@GetMapping("/myPage/bookMark")
	public String myPageBookMark(HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MyPageVO member = mypageService.selectMember(user.getMem_num());
		model.addAttribute("member",member);
		return "bookMark";
	}
	
	
	//게시판 - 내가 쓴 글
	@GetMapping("/myPage/boardWrite")
	public String myPageBoardWrite(@RequestParam(defaultValue = "") String cb_type,HttpSession session, Model model) {
		
		log.debug("<<카테고리 타입 >> : " + cb_type);
		
		MemberVO user = (MemberVO)session.getAttribute("user");	
		MyPageVO member = mypageService.selectMember(user.getMem_num());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cb_type", cb_type);
		map.put("mem_num",user.getMem_num());
		
		List<BoardVO> list = null;
		int count = mypageService.cBoardWriteListcnt(map);
		if(count > 0) {
			list = mypageService.selectMemcBoardWriteList(map);
			
			log.debug("<<  글 목록 >> : " + list);
		}
		map.put("list", list);
		map.put("count", count);
		
		model.addAttribute("member",member);
		return "myBoardWrite";
	}
	
	
	//게시판 - 내가 쓴 댓글
	@GetMapping("/myPage/boardReply")
	public String myPageBoardReply(HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MyPageVO member = mypageService.selectMember(user.getMem_num());
		model.addAttribute("member",member);
		return "myBoardReply";
	}
	
	
	//내 캘린더
	
	
	
	
	//이벤트 참여 내역
	@GetMapping("/myPage/myEvent")
	public String myPageEvent(HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MyPageVO member = mypageService.selectMember(user.getMem_num());
		model.addAttribute("member",member);
		return "myEvent";
	}
	
	
	//구매 - 포인트 충전 내역
	@GetMapping("/myPage/pointList")
	public String myPagePointList(HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MyPageVO member = mypageService.selectMember(user.getMem_num());
		model.addAttribute("member",member);
		return "pointList";
	}
	
	
	
	//구매 - 굿즈 결제 내역
	//장바구니
	
	
	//채팅 이력
	@GetMapping("/myPage/chatList")
	public String myPageChatList(HttpSession session,Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MyPageVO member = mypageService.selectMember(user.getMem_num());
		model.addAttribute("member",member);
		return "chatList";
	}
	
	//회원 정보 - 배송지 관리
	@GetMapping("/myPage/addressList")
	public String myPageAddressList(MyPageVO myPageVO, HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MyPageVO member = mypageService.selectMember(user.getMem_num());
		model.addAttribute("member",member);
		return "addressList";
	}
	
	
	//회원 정보 - 비밀번호 변경
	@GetMapping("/myPage/passwdChange")
	public String myPagePasswdChange(MyPageVO myPageVO, HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MyPageVO member = mypageService.selectMember(user.getMem_num());
		model.addAttribute("member",member);
		return "passwdChange";
	}
	
	
	//회원 정보 - 개인정보 변경
	@GetMapping("/myPage/modifyUser")
	public String modifyUser(MyPageVO myPageVO, HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MyPageVO member = mypageService.selectMember(user.getMem_num());
		model.addAttribute("member",member);
		return "modifyUser";
	}
	
	
	//회원 정보 - 회원 탈퇴
	@GetMapping("/myPage/deleteMember")
	public String deleteMember(MyPageVO myPageVO, HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MyPageVO member = mypageService.selectMember(user.getMem_num());
		model.addAttribute("member",member);
		return "deleteMember";
	}
	
	
	//멤버십 구독
	@GetMapping("/myPage/memberShipSub")
	public String myPageMemberShipSub(HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MyPageVO member = mypageService.selectMember(user.getMem_num());
		model.addAttribute("member",member);
		return "memberShipSub";
	}
	
	
	//나의 문의 내역 - 1:1문의
	@GetMapping("/myPage/consult")
	public String myPageConsult(HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MyPageVO member = mypageService.selectMember(user.getMem_num());
		model.addAttribute("member",member);
		return "consult";
	}
	
	// 프로필 사진 출력하기(로그인 전용)
		@GetMapping("/member/photoView")
		public String getProfile(HttpSession session, HttpServletRequest request, Model model) {
			MemberVO user = (MemberVO)session.getAttribute("user");
			log.debug("<< 프로필 사진 출력 >> : " + user);
			
			
			if(user == null) {
				getBasicProfileImage(request, model);
			} else {
				MyPageVO member = mypageService.selectMember(user.getMem_num());
				viewProfile(member, request, model);
			}
			
			return "imageView";
		}
		
		// 프로필 사진 출력하기
		@GetMapping("/member/viewProfile")
		public String getProfileByMem_num(long mem_num, HttpServletRequest request, Model model) {
			MyPageVO member = mypageService.selectMember(mem_num);
			
			viewProfile(member, request, model);
			
			return "imageView";
		}
		
		// 회원 프로필 사진 처리를 위한 공통 코드
		public void viewProfile(MyPageVO member, HttpServletRequest request, Model model) {
			if (member == null || member.getPhoto_name() ==  null) {
				getBasicProfileImage(request, model);
			} else {
				model.addAttribute("imageFile", member.getPhoto());
				model.addAttribute("filename", member.getPhoto_name());
			}
		}
		
		// 기본 이미지 읽어오기
		public void getBasicProfileImage(HttpServletRequest request, Model model) {
			byte[] readbyte = FileUtil.getBytes(request.getServletContext().getRealPath("/image_bundle/profile_none.png"));
			model.addAttribute("imageFile", readbyte);
			model.addAttribute("filename", "profile_none.png");
		}
		
		
		// 마이페이지 구매 내역 페이지로 가기
		@GetMapping("/myPage/bought")
		public String getMyPageBought(MemberVO memberVO,HttpSession session, Model model) {
			MemberVO user = (MemberVO)session.getAttribute("user");
			MyPageVO member = mypageService.selectMember(user.getMem_num());
			model.addAttribute("member",member);
			return "bought";
		}
		
		// 마이페이지 구매 내역 상세 페이지로 가기
		@GetMapping("/myPage/boughtDetail")
		public String getMyPageDetailBought(MemberVO memberVO,HttpSession session, Model model) {
			MemberVO user = (MemberVO)session.getAttribute("user");
			MyPageVO member = mypageService.selectMember(user.getMem_num());
			model.addAttribute("member",member);
			return "boughtDetail";
		}
		
}
