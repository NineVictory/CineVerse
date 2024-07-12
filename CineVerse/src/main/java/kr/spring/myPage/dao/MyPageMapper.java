package kr.spring.myPage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.board.vo.BoardVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.myPage.vo.MyPageVO;

@Mapper
public interface MyPageMapper {
	@Select("SELECT * FROM member JOIN member_detail  USING(mem_num) WHERE mem_num=#{mem_num}")
	public MyPageVO selectMember(long mem_num);//회원 정보 가져오기
	@Select("SELECT COUNT(*) FROM member_coupon WHERE mem_num=#{mem_num}")
	public Integer selectMemberCoupon(long mem_num);	// 회원 쿠폰 개수 구하기
	public List<MyPageVO> selectMemCouponList(Map<String, Object> map);	// 회원 쿠폰 목록 불러오기
	public List<BoardVO> selectMemcBoardWriteList(Map<String, Object> map);//내가 쓴 게시글 목록
	public Integer cBoardWriteListcnt(Map<String, Object> map);
	@Update("UPDATE member SET mem_nickname=#{mem_nickname} WHERE mem_num=#{mem_num}")
	public void updateMember(MemberVO member);
	public void updateMember_detail(MemberVO member);
	
	@Select("SELECT COUNT(*) FROM point_history WHERE mem_num=#{mem_num}")
	public Integer pointHistoryCnt(long mem_num);
	@Select("SELECT * FROM point_history WHERE mem_num=#{mem_num}")
	public List<MyPageVO> selectMemPointList(Map<String, Object> map); // 회원 포인트 충전 내역 목록 가져오기

}
