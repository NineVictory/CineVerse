package kr.spring.myPage.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.myPage.vo.MyPageVO;

@Mapper
public interface MyPageMapper {
	@Select("SELECT * FROM member JOIN member_detail  USING(mem_num) WHERE mem_num=#{mem_num}")
	public MyPageVO selectMember(long mem_num);//회원 정보 가져오기
	@Select("SELECT SUM(ph_point) FROM point_history WHERE mem_num=${mem_num}")
	public Integer selectMemberPoint(long mem_num);//회원 포인트
}
