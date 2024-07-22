package kr.spring.member.service;

import java.util.List;

import kr.spring.member.vo.CouponVO;
import kr.spring.member.vo.MemberVO;

public interface MemberService {
	public void insertMember(MemberVO member);

	public MemberVO selectCheckMember(String mem_id);

	public void updateAu_id(String au_id, Long mem_num);

	public MemberVO selectAu_id(String au_id);

	public void deleteAu_id(Long mem_num);

	// 전화 번호 중복 체크
	public MemberVO selectCheckPMember(String mem_phone);

	// 이메일 중복 체크
	public MemberVO selectCheckEMember(String mem_email);

	// 아이디 찾기
	public MemberVO findId(MemberVO member);
	// 비밀번호 찾기
	//public MemberVO updateRandomPasswd(MemberVO member);

	public void updatePassword(MemberVO member);
	
	public void chargePoint(Long ph_point, Long mem_num, String ph_payment);
	public List<Long> selectInitialCoupons();
	public void insertNewMemCoupon(CouponVO coupon);
	
	public void totalPoint(Long mem_num);
	
	public void insertKakaoMemberDetail(MemberVO member);
	
	public MemberVO selectMember(Long mem_num);
	public Integer selectPointUse(Long mem_num);
	
}
