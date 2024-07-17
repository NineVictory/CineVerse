package kr.spring.myPage.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import kr.spring.assignment.vo.AssignVO;
import kr.spring.board.vo.BoardCommentVO;
import kr.spring.board.vo.BoardFavVO;
import kr.spring.board.vo.BoardVO;
import kr.spring.myPage.vo.MyPageVO;

public interface MyPageService {
	public MyPageVO selectMember(long mem_num);//회원 정보 가져오기
	public Integer selectMemberCoupon(long mem_num);	//회원 쿠폰 개수 가져오기
	public List<MyPageVO> selectMemCouponList(Map<String, Object> map); //회원 쿠폰 목록 불러오기
	public List<BoardVO> selectMemcBoardWriteList(Map<String, Object> map);//내가 쓴 게시글 목록
	public Integer cBoardWriteListcnt(Map<String, Object> map);
	public List<BoardCommentVO> cBoardReplyList(Map<String, Object> map);//내가 쓴 댓글 목록
	public Integer cBoardResponsecnt(Map<String, Object> map);
	public List<BoardCommentVO> cBoardResponseList(Map<String, Object> map); // 내가 쓴 답글 목록
	public Integer cBoardReplyListcnt(Map<String, Object> map);
	public void updatePassword(MyPageVO mypage);//비밀번호 수정
	public Integer pointHistoryCnt(long mem_num);//포인트
	public List<MyPageVO> selectMemPointList(Map<String, Object> map);
	public void updateMember_detail(MyPageVO myPageVO);
	public void updateProfile(MyPageVO myPageVO);// 프로필 이미지 업데이트
	public Integer aBoardListcnt(Map<String, Object> map);
	public List<AssignVO> aBoardList(Map<String, Object> map);
	public Integer aBoardBookMark(Map<String, Object> map);
	public List<AssignVO> aBoardBookMarkList(Map<String, Object> map);
	public Integer cBoardBookMark(Map<String, Object> map);
	public List<BoardVO> cBoardBookMarkList(Map<String, Object> map);
	public Integer cBoardWriteFavCnt(Map<String, Object> map);
	public List<BoardFavVO> cBoardWriteFavList(Map<String, Object> map);
}
