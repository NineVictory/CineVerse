package kr.spring.myPage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.assignment.vo.AssignVO;
import kr.spring.board.vo.BoardCommentVO;
import kr.spring.board.vo.BoardFavVO;
import kr.spring.board.vo.BoardVO;
import kr.spring.member.vo.CouponVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.movie.vo.MovieBookMarkVO;
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

	//구독 목록 보기
	@Select("SELECT * FROM member WHERE mem_num=#{mem_num}")
	public MyPageVO selectMembership(Long mem_num);
	//구독중 2로 변경
	// member 테이블의 상태 변경해주는 코드
	@Update("UPDATE member SET mem_membership=2 WHERE mem_num=#{mem_num} AND mem_membership=1")
	public void updateMembership(Long mem_num);
	// 멤버십업데이트 테이블에 행을 삽입하는 코드
	@Insert("INSERT INTO membership_update(mu_num,mem_num,mu_date) VALUES(membership_update_seq.nextval,#{mem_num},SYSDATE)")
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









	//기대하는 영화
	@Select("SELECT COUNT(*) FROM movie_bookmark WHERE mem_num=#{mem_num}")
	public Integer movieBookMarkcnt(Long mem_num);
	public List<MovieBookMarkVO> movieBookMarkList(Map<String, Object> map);//xml추가



}
