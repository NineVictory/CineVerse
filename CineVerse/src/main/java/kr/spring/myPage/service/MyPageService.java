package kr.spring.myPage.service;

import java.util.List;
import java.util.Map;

import kr.spring.board.vo.BoardVO;
import kr.spring.myPage.vo.MyPageVO;

public interface MyPageService {
	public MyPageVO selectMember(long mem_num);//회원 정보 가져오기
	public Integer selectMemberCoupon(long mem_num);	//회원 쿠폰 개수 가져오기
	public List<MyPageVO> selectMemCouponList(Map<String, Object> map); //회원 쿠폰 목록 불러오기
	public List<BoardVO> selectMemcBoardWriteList(Map<String, Object> map);//내가 쓴 게시글 목록
	public Integer cBoardWriteListcnt(Map<String, Object> map);
	
	public void updatePassword(MyPageVO mypage);//비밀번호 수정
	
	//포인트
	public Integer pointHistoryCnt(long mem_num);
	public List<MyPageVO> selectMemPointList(Map<String, Object> map);
}
