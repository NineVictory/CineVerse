package kr.spring.myPage.service;

import kr.spring.myPage.vo.MyPageVO;

public interface MyPageService {
	public MyPageVO selectMember(long mem_num);//회원 정보 가져오기
	public int selectMemberPoint(long mem_num);//회원 포인트
}
