package kr.spring.member.service;

import kr.spring.member.vo.MemberVO;

public interface MemberService {
	public void insertMember(MemberVO member);

	public MemberVO selectCheckMember(String mem_id);

	public void updateAu_id(String au_id, Long mem_num);

	public void selectAu_id(String au_id);

	public void deleteAu_id(Long mem_num);

	// 전화 번호 중복 체크
	public MemberVO selectCheckPMember(String mem_phone);

	// 이메일 중복 체크
	public MemberVO selectCheckEMember(String mem_email);
}
