package kr.spring.myPage.service;

import kr.spring.myPage.vo.MyPageVO;

public interface MyPageService {
	public MyPageVO selectMember(long mem_num);//회원 정보 가져오기
	public Integer selectMemberPoint(long mem_num);//회원 포인트
	public Integer selectMemberCoupon(long mem_num);	// 회원 쿠폰 개수 가져오기
}
