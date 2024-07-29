package kr.spring.admin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.admin.vo.AdminVO;
import kr.spring.admin.vo.EventVO;
import kr.spring.admin.vo.FaqVO;
import kr.spring.admin.vo.NoticeVO;
import kr.spring.admin.vo.ReMovieVO;
import kr.spring.admin.vo.RefundMbVO;
import kr.spring.admin.vo.ReplyVO;
import kr.spring.assignment.vo.AssignVO;
import kr.spring.board.vo.BoardCommentVO;
import kr.spring.board.vo.BoardVO;
import kr.spring.cinema.vo.CinemaVO;
import kr.spring.cinema.vo.TheaterVO;
import kr.spring.member.vo.PointVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.shop.vo.OrdersVO;
import kr.spring.support.vo.ConsultVO;

@Mapper
public interface AdminMapper {
	// 메인페이지 통계
	@Select("SELECT COUNT(*) FROM member WHERE mem_auth = 2 OR mem_auth = 3")
	public Integer totalMember();

	@Select("SELECT COUNT(*) FROM community_board")
	public Integer totalCommunity();

	@Select("SELECT COUNT(*) FROM assignment_board")
	public Integer totalAssignment();

	@Select("SELECT COUNT(*) FROM product WHERE p_status = 2")
	public Integer totalProduct();

	@Select("SELECT COUNT(*) FROM movie WHERE m_status = 1 AND m_delete = 1")
	public Integer totalMovie();

	@Select("SELECT COUNT(*) FROM cinema")
	public Integer totalCinema();

	@Select("SELECT COUNT(*) FROM consult WHERE consult_status = 1")
	public Integer totalConsult();
	

	// 회원 관리
	public List<AdminVO> selectMemberList(Map<String, Object> map);

	public Integer selectMemberRowCount(Map<String, Object> map);

	@Update("UPDATE member SET mem_auth = 1 WHERE mem_num=#{mem_num}")
	public void deleteMemberAuth(long mem_num);

	@Update("UPDATE member SET mem_auth = 2 WHERE mem_num=#{mem_num}")
	public void updateMemberAuth(long mem_num);

	// 구독 맴버십
	public List<AdminVO> selectMembershipList(Map<String, Object> map);

	public Integer selectMembershipRowCount(Map<String, Object> map);

	@Insert("INSERT INTO point_history (ph_num, ph_point, ph_date, mem_num, ph_type, ph_payment) VALUES (point_history_seq.nextval, 10000, SYSDATE, #{mem_num}, 0, #{point_payment})")
	public void refundMembership(long mem_num, @Param("point_payment") String point_payment);

	@Delete("DELETE FROM membership_update WHERE mem_num = #{mem_num}")
	public void deleteMembership(long mem_num);

	@Update("UPDATE member SET mem_membership = 1 WHERE mem_num=#{mem_num}")
	public void updateMembership(long mem_num);

	@Delete("DELETE FROM member_coupon WHERE mem_num = #{mem_num} AND (coupon_num = 21 OR coupon_num = 22)")
	public void deleteCoupon(long mem_num);

	// 공지사항
	public List<NoticeVO> selectNoticeList(Map<String, Object> map);

	public Integer selectNoticeRowCount(Map<String, Object> map);

	public void insertNotice(NoticeVO noticeVO);
	
	@Select("select * from notice_board WHERE nb_num = #{nb_num}")
	public NoticeVO selectNotice(long nb_num);
	
	public void modifyNotice(NoticeVO noticeVO);
	
	@Delete("DELETE FROM notice_board WHERE nb_num = #{nb_num}")
	public void deleteNotice(long nb_num);

	// FAQ
	public List<FaqVO> selectFaqList(Map<String, Object> map);

	public Integer selectFaqRowCount(Map<String, Object> map);

	public void insertFaq(FaqVO FaqVO);

	@Delete("DELETE FROM faq WHERE f_num = #{f_num}")
	public void deleteFaq(long f_num);

	// 이벤트
	public List<EventVO> selectEventList(Map<String, Object> map);

	public Integer selectEventRowCount(Map<String, Object> map);

	public void insertEvent(EventVO eventVO);
	@Select("select * from event WHERE event_num = #{event_num}")
	public EventVO selectEvent(long event_num);
	public void modifyEvent(EventVO eventVO);
	
	@Delete("DELETE FROM event WHERE event_num = #{event_num}")
	public void deleteEvent(long event_num);

	// 게시판
	// 자유
	public List<BoardVO> selectCommunityList(Map<String, Object> map);

	public Integer selectCommunityRowCount(Map<String, Object> map);

	// 양도/교환
	public List<AssignVO> selectAssignList(Map<String, Object> map);

	public Integer selectAssignRowCount(Map<String, Object> map);

	// 댓글관리
	public List<ReplyVO> selectReCmtList(Map<String, Object> map);

	public List<ReplyVO> selectReplyList(Map<String, Object> map);

	public Integer selectReplyRowCount(Map<String, Object> map);

	public Integer selectReCmtRowCount(Map<String, Object> map);

	// 댓글삭제
	@Delete("DELETE FROM community_comment WHERE cc_num = #{cc_num}")
	public void deleteReply(long cc_num);

	@Delete("DELETE FROM community_response WHERE te_num = #{te_num}")
	public void deleteCmt(long cc_num);

	// 영화
	public List<MovieVO> selectMovie(Map<String, Object> map);

	public Integer selectMovieRowCount(Map<String, Object> map);
	//영화 수정
	@Select("select * from movie WHERE m_code = #{m_code}")
	public MovieVO selectMovie1(long m_code);
	public void modifyMovie(MovieVO movieVO);
	
	//영화 삭제
	@Update("UPDATE movie SET m_delete = 2 WHERE m_code = #{m_code} AND m_status = 2")
	public Integer deleteMovie(long m_code);

	// 영화관 등록
	@Select("SELECT cinema_num.nextval FROM dual")
	public Long selectC_num();

	// 영화관 목록
	public List<CinemaVO> selectCinema(Map<String, Object> map);

	public Integer selectCinemaRowCount(Map<String, Object> map);
	
	//영화관 등록
	public void insertCinema(CinemaVO cinemaVO);
	
	//영화관 삭제
	@Update("UPDATE cinema SET c_status = 0 WHERE c_num = #{c_num}")
	public void deleteCinema(long c_num);
	
	//영화관 수정
	@Select("select * from cinema WHERE c_num = #{c_num}")
	public CinemaVO selectCinema1(long c_num);
	public void modifyCinema(CinemaVO cinemaVO);
	
	// 상영관 등록
	public void insertTheater(TheaterVO theaterVO);

	// 영화,상영관 검색
	public List<TheaterVO> selectTheater(int c_num);

	// 결제
	public List<PointVO> selectPoint(Map<String, Object> map);

	public Integer selectPointRowCount(Map<String, Object> map);

	@Insert("INSERT INTO point_history (ph_num, ph_point, ph_date, mem_num, ph_type, ph_payment) VALUES (point_history_seq.nextval, #{ph_point}, SYSDATE, #{mem_num}, 0, #{ph_payment})")
	public void refundPoint(@Param("ph_num") long ph_num, @Param("mem_num") long mem_num,
			@Param("ph_point") long ph_point, @Param("ph_payment") String ph_payment);

	@Update("UPDATE point_history SET ph_type = 3 WHERE ph_num = #{ph_num}")
	public void updatePoint(long ph_num);

	// 문의
	public List<ConsultVO> selectConsultList(Map<String, Object> map);

	public Integer selectConsultRowCount(Map<String, Object> map);

	@Select("SELECT * FROM consult JOIN member USING(mem_num) LEFT OUTER JOIN member_detail USING(mem_num) WHERE consult_num=#{consult_num}")
	public ConsultVO selectConsult(long consult_num);

	@Update("UPDATE consult SET consult_modify_date = SYSDATE, consult_status = 2, consult_answer = #{consult_answer, jdbcType=VARCHAR} WHERE consult_num = #{consult_num}")
	public void updateAnswer(ConsultVO consultVO);

	// 예매 취소

	// 예약
	public List<RefundMbVO> selectReservation(Map<String, Object> map);

	public Integer selectReservationRowCount(Map<String, Object> map);

	// 환불처리
	@Select("SELECT COUNT(*) FROM mb_detail WHERE md_type = 1 AND mb_num = #{mb_num}")
	public Integer totalMb(@Param("mb_num") long mb_num);

	@Insert("INSERT INTO point_history (ph_num, ph_point, ph_date, mem_num, ph_type, ph_payment) VALUES (point_history_seq.nextval, #{mb_price}, SYSDATE, #{mem_num}, 4, #{ph_payment})")
	public void refundMovie(@Param("mem_num") long mem_num, @Param("mb_price") long mb_price,
			@Param("ph_payment") String ph_payment, @Param("mb_num") long mb_num);

	// 예매취소설정
	@Update("UPDATE mb_detail md SET md.md_type = 2 WHERE md.mb_num IN (SELECT m.mb_num FROM movie_booking m WHERE md.mb_num = #{mb_num})")
	public void updateMb(long mb_num);

	//주문취소
	// 주문목록
	public List<OrdersVO> selectOrder(Map<String, Object> map);
	public Integer selectOrderRowCount(Map<String, Object> map);
	
	// 환불처리
	@Insert("INSERT INTO point_history (ph_num, ph_point, ph_date, mem_num, ph_type, ph_payment) VALUES (point_history_seq.nextval, #{p_price}, SYSDATE, #{mem_num}, 4, #{ph_payment})")
	public void refundShop(@Param("mem_num") long mem_num,@Param("ph_payment") String ph_payment,@Param("order_num") long order_num,@Param("order_quantity") long order_quantity,@Param("p_price") long p_price);

	// 상품 수량 업데이트
	@Update("UPDATE order_detail SET order_quantity = order_quantity + #{order_quantity} WHERE order_num = #{order_num}")
	public void updateOdQuantity(@Param("order_num") long order_num, @Param("order_quantity") long order_quantity);
	
	// 예매취소설정
	@Update("UPDATE orders SET order_status = 5 WHERE order_num = #{order_num}") 
	public void updateOdStauts(long order_num);
	
	//이벤트 참여한 사람 count 구하기 
	@Select("SELECT COUNT(*) FROM event_participation WHERE event_num=#{event_num}")
	public Integer selectEventParticipantsCnt(long event_num);
	
	// 이벤트 참여한 사람 list 구하기
	@Select("SELECT ep.*, e.event_name, m.mem_id FROM event_participation ep JOIN event e ON e.event_num = ep.event_num JOIN member m ON m.mem_num=ep.mem_num WHERE ep.event_num=#{event_num}")
	public List<EventVO> selectEventParticipants(long event_num);
	
	// 해당 이벤트 번호에 type이 2인 사람이 있다면 당첨자 발표 막기
	@Select("SELECT COUNT(*) FROM event_participation WHERE ep_result=2 AND event_num=#{event_num}")
	public Integer selectEventResultShow(long event_num);
	
	// 이벤트에서 총 몇 명 뽑을건지 테이블에 등록된 내용 가져오기
	@Select("SELECT event_drawn FROM event WHERE event_num=#{event_num}")
	public int selectChoiceNumber(long event_num);
	
	// 당첨자를 뽑을 이벤트에 참여한 사람의 mem_num 가져오기
	@Select("SELECT mem_num FROM event_participation JOIN member USING(mem_num) WHERE event_num=#{event_num} AND mem_auth=3")
	public List<Long> selectMemberNumberEvent(long event_num);
	
	// 당첨된 사람들의 결과를 업데이트 시키기
	@Update("UPDATE event_participation SET ep_result=2 WHERE mem_num=#{mem_num} AND event_num=#{event_num}")
	public void updateEventResult(long mem_num,long event_num);
	
	// 영화리뷰
	public List<ReMovieVO> selectReMovie(Map<String, Object> map);

	public Integer selectReMovieRowCount(Map<String, Object> map);
	
	//영화리뷰삭제
	@Update("UPDATE movie_review SET mr_status=1 WHERE mr_num=#{mr_num}")
	public void updateMovieReview(long mr_num);
	
	
}
