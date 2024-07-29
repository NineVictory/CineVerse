package kr.spring.myPage.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.admin.vo.EventVO;
import kr.spring.assignment.vo.AssignVO;
import kr.spring.board.vo.BoardCommentVO;
import kr.spring.board.vo.BoardFavVO;
import kr.spring.board.vo.BoardVO;
import kr.spring.member.vo.CouponVO;
import kr.spring.movie.vo.MovieBookMarkVO;
import kr.spring.movie.vo.MovieBookingVO;
import kr.spring.movie.vo.MovieReviewVO;
import kr.spring.myPage.vo.MyPageVO;
import kr.spring.support.vo.ConsultVO;

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
	public Integer movieBookMarkcnt(Long mem_num);
	public List<MovieBookMarkVO> movieBookMarkList(Long mem_num);
	public void updateMembership(Long mem_num);
	public void insertMembership(Long mem_num);
	public void usePoint(Long mem_num);
	public void insertNewMemCoupon(CouponVO coupon);
	public List<Long> selectInitialCoupons();
	public CouponVO selectMembershipSub(Long mem_num);
	public Integer consultcnt(Map<String, Object> map);//문의 갯수
	public List<ConsultVO> consultList(Map<String, Object> map);//문의 목록
	public ConsultVO lastConsert(Long mem_num);
	public void updateNoSub();
	public void updateNoSubDate();
	public Integer eventcnt(Map<String, Object> map);//이벤트 갯수
	public List<EventVO> eventList(Map<String, Object> map);
	public Integer reservationCnt(Map<String, Object> map);
	public Integer watMovieCnt(Map<String, Object> map);
	public List<MovieBookingVO> reservationList(Long mem_num);
	
	
	public Integer resDetailCnt(Long mem_num);
	public MovieBookingVO resDetail(Long mb_num);

	public List<MovieBookingVO> lastRes(Long mem_num);
	public MovieBookingVO mainRes(Long mem_num);//메인나브
	public void updateCoupon(Long mem_num);
	public void updatePoint(Long mem_num);
	public Integer movieReviewCnt(Long mem_num);
	public List<MovieReviewVO> movieReviewList(Long mem_num);
	public void delMovieRev(Long mr_num);
	//내가 본 영화 md_type==1
	public List<MovieBookingVO> watchedMovList(Map<String, Object> map);

	public List<MovieBookingVO> selectRow(Long mb_num);
	public List<MovieBookingVO> selectColumn(Long mb_num);
	public Integer mdCount(Long mb_num);
	
	//영화포인트
	public Integer selectPayCouponCnt(Long mem_coupon_use,Long mem_num);
	public MyPageVO selectCouponPrice(Long mc_num);
	
}
