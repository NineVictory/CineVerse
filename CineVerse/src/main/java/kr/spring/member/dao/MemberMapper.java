package kr.spring.member.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.member.vo.MemberVO;


@Mapper
public interface MemberMapper {
	
	// 회원 관리 - 일반 회원
	@Select("SELECT member_seq.nextval FROM dual")
	public Long selectMem_num();
	@Insert("INSERT INTO member (mem_num, mem_id, mem_auth, mem_rank, mem_membership) VALUES (#{mem_num}, #{mem_id}, 3, 1, 1)")
	public void insertMember(MemberVO member);
	// xml 작성
	public void insertMember_detail(MemberVO member);
	public MemberVO selectCheckMember(String mem_id);
	// 전화 번호 중복 체크
	public MemberVO selectCheckPMember(String mem_phone);
	// 이메일 중복 체크
	public MemberVO selectCheckEMember(String mem_email);
	public void updateAu_id(String au_id, Long mem_num);
	public void selectAu_id(String au_id);
	public void deleteAu_id(Long mem_num);
	
	//아이디 찾기
	@Select("SELECT * FROM member LEFT OUTER JOIN member_detail USING(mem_num) WHERE mem_name=#{mem_name} AND mem_phone=#{mem_phone}")
	public MemberVO findId(MemberVO member);
	// 비밀번호 찾기
	public MemberVO updateRandomPasswd(MemberVO member);
	
	
}
