package kr.spring.myPage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.assignment.vo.AssignVO;
import kr.spring.board.vo.BoardCommentVO;
import kr.spring.board.vo.BoardFavVO;
import kr.spring.board.vo.BoardVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.movie.vo.MovieBookMarkVO;
import kr.spring.myPage.vo.MyPageVO;

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
	
	
	//구독 목록 보기
	@Select("SELECT * FROM member WHERE mem_num=#{mem_num}")
	public MyPageVO selectMembership(Long mem_num);
	//구독중 2로 변경
	@Update("UPDATE member SET mem_membership=2 WHERE mem_num=#{mem_num} AND mem_membership=1")
	public void udpateMembership(Long mem_num);
	
	
	
	
	
	
	
	
	
	
	
	//기대하는 영화
	@Select("SELECT COUNT(*) FROM movie_bookmark WHERE mem_num=#{mem_num}")
	public Integer movieBookMarkcnt(Long mem_num);
	public List<MovieBookMarkVO> movieBookMarkList(Map<String, Object> map);//xml추가

	
	
}
