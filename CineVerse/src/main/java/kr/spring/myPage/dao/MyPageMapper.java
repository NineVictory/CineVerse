package kr.spring.myPage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.admin.vo.EventVO;
import kr.spring.assignment.vo.AssignVO;
import kr.spring.board.vo.BoardCommentVO;
import kr.spring.board.vo.BoardFavVO;
import kr.spring.board.vo.BoardVO;
import kr.spring.event.vo.UserEventVO;
import kr.spring.member.vo.CouponVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.movie.vo.MovieBookMarkVO;
import kr.spring.movie.vo.MovieBookingVO;
import kr.spring.movie.vo.MovieReviewVO;
import kr.spring.myPage.vo.MyPageVO;
import kr.spring.support.vo.ConsultVO;

@Mapper
public interface MyPageMapper {
	@Select("SELECT * FROM member JOIN member_detail  USING(mem_num) WHERE mem_num=#{mem_num}")
	public MyPageVO selectMember(Long mem_num);//회원 정보 가져오기
	@Select("SELECT COUNT(*) FROM member_coupon WHERE mem_num=#{mem_num} AND coupon_use = 1")
	public Integer selectMemberCoupon(Long mem_num);	// 회원 쿠폰 개수 구하기
	public List<MyPageVO> selectMemCouponList(Map<String, Object> map);	// 회원 쿠폰 목록 불러오기
	public Integer cBoardWriteListcnt(Map<String, Object> map);
	public List<BoardVO> selectMemcBoardWriteList(Map<String, Object> map);//내가 쓴 게시글 목록
	public Integer cBoardReplyListcnt(Map<String, Object> map);
	public List<BoardCommentVO> cBoardReplyList(Map<String, Object> map);//내가 쓴 댓글 목록
	public Integer cBoardResponsecnt(Map<String, Object> map);
	public List<BoardCommentVO> cBoardResponseList(Map<String, Object> map); // 내가 쓴 답글 목록
	@Update("UPDATE member_detail SET mem_passwd=#{mem_passwd} WHERE mem_num=#{mem_num}")
	public void updatePassword(MyPageVO mypage);//비밀번호 변경
	@Select("SELECT COUNT(*) FROM point_history WHERE mem_num=#{mem_num}")//포인트
	public Integer pointHistoryCnt(Long mem_num);
	@Select("SELECT * FROM point_history WHERE mem_num=#{mem_num}")
	public List<MyPageVO> selectMemPointList(Map<String, Object> map); // 회원 포인트 충전 내역 목록 가져오기
	public void updateMember_detail(MyPageVO myPageVO);
	@Update("UPDATE member_detail SET photo=#{photo}, photo_name=#{photo_name} WHERE mem_num=#{mem_num}")
	public void updateProfile(MyPageVO myPageVO);// 프로필 이미지 업데이트
	public Integer aBoardListcnt(Map<String, Object> map);//양도게시글
	public List<AssignVO> aBoardList(Map<String, Object> map);
	public Integer aBoardBookMark(Map<String, Object> map);//양도북마크
	public List<AssignVO> aBoardBookMarkList(Map<String, Object> map);
	public Integer cBoardWriteFavCnt(Map<String, Object> map);//일반 커뮤니티 좋아요
	public List<BoardFavVO> cBoardWriteFavList(Map<String, Object> map);
	public Integer cBoardBookMark(Map<String, Object> map);//일반 커뮤니티 북마크
	public List<BoardVO> cBoardBookMarkList(Map<String, Object> map);
	public Integer consultcnt(Map<String, Object> map);//문의 갯수
	public List<ConsultVO> consultList(Map<String, Object> map);//문의 목록
	@Select("SELECT * FROM (SELECT * FROM consult  WHERE mem_num = #{mem_num} ORDER BY consult_num DESC) WHERE ROWNUM = 1")
	public ConsultVO lastConsert(Long mem_num);//마지막 문의글
	
	
	
	public Integer eventcnt(Map<String, Object> map);//이벤트 갯수
	public List<UserEventVO> eventList(Map<String, Object> map);
	
	
	
	
	//기대하는 영화
	@Select("SELECT COUNT(*) FROM movie_bookmark WHERE mem_num=#{mem_num}")
	public Integer movieBookMarkcnt(Long mem_num);
	@Select("SELECT m.m_name,m.m_filename,m.m_code FROM movie_bookmark mb JOIN movie m ON m.m_code=mb.m_code WHERE mb.mem_num=#{mem_num}")
	public List<MovieBookMarkVO> movieBookMarkList(Long mem_num);
	public Integer reservationCnt(Map<String, Object> map);
	public Integer watMovieCnt(Map<String, Object> map);
	//내가 본 영화
	public List<MovieBookingVO> watchedMovList(Map<String, Object> map);//1 리스트
	//모든 영화 카운트
	public Integer resDetailCnt(Long mem_num);
	//예매 디테일
	public MovieBookingVO resDetail(Long mb_num);

	public List<MovieBookingVO> reservationList(Long mem_num);
	public List<MovieBookingVO> lastRes(Long mem_num);
	public MovieBookingVO mainRes(Long mem_num);//메인나브
	
	//영화 리뷰
	@Select("SELECT COUNT(*) FROM movie_review WHERE mem_num=#{mem_num}")
	public Integer movieReviewCnt(Long mem_num);
	@Select("SELECT * FROM movie_review LEFT OUTER JOIN(SELECT mr_num, COUNT(*) AS fav_cnt FROM mr_fav GROUP BY mr_num) USING(mr_num) JOIN member_detail USING(mem_num) WHERE mem_num=#{mem_num}")
	public List<MovieReviewVO> movieReviewList(Long mem_num);
	
	//영화 리뷰 삭제
	@Delete("DELETE FROM mr_fav WHERE mr_num=#{mr_num}")
	public void delMovieRev_fav(Long mr_num);
	@Delete("DELETE FROM movie_review WHERE mr_num=#{mr_num}")
	public void delMovieRev(Long mr_num);
	
	//쿠폰사용 1로 변경
	@Update("UPDATE member_coupon SET coupon_use=2 WHERE mem_num=#{mem_num}")
	public void updateCoupon(Long mem_num);
	//포인트 환불
	@Insert("INSERT INTO point_history(ph_num,ph_point,ph_date,mem_num,ph_type,ph_payment) VALUES(point_history_seq.nextval,#{ph_point},SYSDATE,#{mem_num},0,'환불'")
	public void updatePoint(Long mem_num);
	
	//구독 목록 보기
	@Select("SELECT * FROM member WHERE mem_num=#{mem_num}")
	public MyPageVO selectMembership(Long mem_num);
	//구독중 2로 변경
	// member 테이블의 상태 변경해주는 코드
	@Update("UPDATE member SET mem_membership=2 WHERE mem_num=#{mem_num} AND mem_membership=1")
	public void updateMembership(Long mem_num);
	// 멤버십업데이트 테이블에 행을 삽입하는 코드
	@Update("UPDATE member_detail SET mem_membership_date = SYSDATE WHERE mem_num=#{mem_num}")
	public void insertMembership(Long mem_num);
	// 멤버십 구독 후 포인트 사용하는 history 넣어줌
	@Insert("INSERT INTO point_history(ph_num,ph_point,ph_date,mem_num,ph_type,ph_payment) VALUES(point_history_seq.nextval,10000,SYSDATE,#{mem_num},1,'membership')")
	public void usePoint(Long mem_num);
	//멤버십 구독 쿠폰 증정
	@Insert("INSERT INTO member_coupon (mc_num, mem_num, coupon_num) VALUES (member_coupon_seq.nextval,#{mem_num}, #{coupon_num})")
	public void insertNewMemCoupon(CouponVO coupon);
	// 쿠폰 DB에 존재하는 쿠폰을 멤버십 구독한 멤버들에게 21번, 22번 쿠폰 찾기
	@Select("SELECT coupon_num FROM coupon_db WHERE coupon_num IN (21, 22)")
	public List<Long> selectInitialCoupons();
	// 멤버십 구독 상태 확인
	@Select("SELECT * FROM membership_update WHERE mem_num=#{mem_num}")
	public CouponVO selectMembershipSub(Long mem_num);
	@Update("UPDATE member_coupon SET coupon_use = 3 WHERE ADD_MONTHS(coupon_regdate, 1) < SYSDATE")
	public void updateCouponstatus();

	@Update("UPDATE member SET mem_membership = 1 WHERE mem_num=(SELECT mem_num FROM member_detail WHERE ADD_MONTHS(mem_membership_date,1)<SYSDATE)")
	public void updateNoSub();
	@Update("UPDATE member_detail SET mem_membership_date = NULL WHERE mem_num=(SELECT mem_num FROM member_detail WHERE ADD_MONTHS(mem_membership_date,1)<SYSDATE)")
	public void updateNoSubDate();
	@Select("SELECT seat_row FROM seat JOIN mb_detail USING(seat_num) WHERE mb_num=#{mb_num}")
	public List<MovieBookingVO> selectRow(Long mb_num);
	@Select("SELECT seat_column FROM seat JOIN mb_detail USING(seat_num) WHERE mb_num=#{mb_num}")
	public List<MovieBookingVO> selectColumn(Long mb_num);
	@Select("SELECT COUNT(*) FROM mb_detail WHERE mb_num=#{mb_num}")
	public Integer mdCount(Long mb_num);
	
	
	
	//영화상세 포인트 가격
	@Select("SELECT COUNT(*) FROM member_coupon WHERE coupon_use=2 and mem_num=#{mem_num}")
	public Integer selectPayCouponCnt(Long mem_num);
	
	@Select("SELECT * FROM member_coupon mc JOIN coupon_db cd on mc.coupon_num=cd.coupon_num WHERE cd.coupon_where=1 AND mc.mem_coupon_use=#{mem_coupon_use}")
	public MyPageVO selectCouponPrice(Long mem_coupon_use);

	
	
	
	
	
	// 회원 탈퇴 관련
	// 벌스샵 관련
	// address 삭제
	public void deleteaddressmem(Long mem_num);
	// pbasket 삭제
	public void deletePbasketmem(Long mem_num);
	//상품 리뷰 삭제
	public void deletePreview(Long mem_num);
	// 상품 좋아요 삭제
	public void deletePfav(Long mem_num);
	//주문 세부 정보
	public void deleteOrderdetail(Long mem_num);
	// 주문
	public void deleteOrders(Long mem_num);
	
	// assignboard 신고 삭제
	public void deleteAssingReport(Long mem_num);
	public void deleteAssingReportAll(Long mem_num);
	// 양도 북마크 삭제
	public void deleteAbmark(Long mem_num);
	public void deleteAbmarkAll(Long mem_num);
	// 양도 글 삭제
	public void deleteAssignBoard(Long mem_num);
	
	// 커뮤니티 신고 삭제
	public void deleteCommunityReport(Long mem_num);
	public void deleteCommunityReportA(Long mem_num);
	
	public void deleteCommentReport(Long mem_num);
	public void deleteCommentReportA(Long mem_num);
	
	public void deleteResponseReport(Long mem_num);
	public void deleteResponseReportA(Long mem_num);
	
	// 커뮤니티 좋아요 삭제
	public void deleteCommunityResFav(Long mem_num);
	public void deleteCommunityResFavA(Long mem_num);
	
	public void deleteCommunityComFav(Long mem_num);
	public void deleteCommunityComFavA(Long mem_num);
	
	public void deleteCommunityFav(Long mem_num);
	public void deleteCommunityFavA(Long mem_num);

	//커뮤니티 북마크 삭제
	public void deleteCommunityCB(Long mem_num);
	public void deleteCommunityCBA(Long mem_num);
	
	// 커뮤니티 대댓글 삭제
	public void deleteCommunityCRA(Long mem_num);
	public void deleteCommunityCR(Long mem_num);
	
	// 커뮤니티 댓글 삭제
	public void deleteCommunityC(Long mem_num);
	public void deleteCommunityCA(Long mem_num);
	
	// 커뮤니티 글 삭제
	public void deleteCommunityB(Long mem_num);
	
	// Talk 삭제
    public void deleteTalkReadByMemNum(Long mem_num);

    public void deleteTalkByMemNum(Long mem_num);

    public void deleteTalkMemberByMemNum(Long mem_num);

    public void deleteTalkroomByMemNum(Long mem_num);
	
    public void deleteMreview(Long mem_num);
	// mbdetail 영화 예매 상세 
	public void deleteMbdetail(Long mem_num);
	// moviebooking 영화 예매 상세 
	public void deleteMoviebooking(Long mem_num);
	
	// eventParticipation
	public void deleteEventP(Long mem_num);
	
	// consult 삭제
	public void deleteConsult(Long mem_num);
	
	// member_coupon 삭제
	public void deleteMemCoupon(Long mem_num);
	
	// member_detail 삭제
	public void deleteMemdetail(Long mem_num);
	
	// member_update
	public void updateMem(Long mem_num);
	
	@Delete("DELETE FROM rr_reporter WHERE rr_num IN (SELECT rr_num FROM reviewreport WHERE mr_num IN (SELECT mr_num FROM movie_review WHERE mem_num=#{mem_num}))")
	public void deleterrReport(Long mem_num);
	@Delete("DELETE FROM reviewreport WHERE mr_num IN (SELECT mr_num FROM movie_review WHERE mem_num=#{mem_num})")
	public void deleteReviewReport(Long mem_num);
	@Delete("DELETE FROM movie_review WHERE mem_num=#{mem_num}")
	public void deleteMovieReview(Long mem_num);
	@Delete("DELETE FROM movie_bookmark WHERE mem_num=#{mem_num}")
	public void deleteMovieBookmark(Long mem_num);
	
	@Delete("DELETE FROM talk_read WHERE talkroom_num IN (SELECT talkroom_num FROM talk_member WHERE mem_num=#{mem_num})")
	public void deleteTalkReadTN(Long mem_num);
	@Delete("DELETE FROM talk WHERE talkroom_num IN (SELECT talkroom_num FROM talk_member WHERE mem_num=#{mem_num})")
	public void deleteTalkTN(Long mem_num);
	@Delete("DELETE FROM talk_member WHERE talkroom_num IN (SELECT talkroom_num FROM talk_member WHERE mem_num=#{mem_num})")
	public void deleteTalkMemTN(Long mem_num);
}
