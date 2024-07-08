package kr.spring.myPage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import kr.spring.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MyPageController {
	@GetMapping("/myPage/myPageMain")
	public String myPageMain() {
		return "myPageMain";
	}
	//나의 예매내역
	@GetMapping("/myPage/reservation")
	public String myPageReservation() {
		return "myPageReservation";
	}
	//나의 쿠폰
	//나의 활동 - 기대되는 영화
	@GetMapping("/myPage/expectingMovie")
	public String expectingMovie() {
		return "expectingMovie";
	}
	//나의 활동 - 내가 본 영화
	@GetMapping("/myPage/watchedMovie")
	public String watchedMovie() {
		return "watchedMovie";
	}
	//나의 활동 - 내가 쓴 별점
	//게시판 - 내가 쓴 글
	//게시판 - 내가 쓴 댓글
	//북마크
	//내 캘린더
	//이벤트 참여 내역
	//구매 - 포인트 충전 내역
	//구매 - 굿즈 결제 내역
	//장바구니
	//채팅 이력
	//회원 정보 - 개인정보 변경
	@GetMapping("/myPage/modifyUser")
	public String modifyUser(MemberVO memberVO) {
		return "modifyUser";
	}
	//회원 정보 - 회원 탈퇴
	//멤버십 구독
	//나의 문의 내역 - 1:1문의
}
