package kr.spring.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.member.dao.MemberMapper;
import kr.spring.member.vo.CouponVO;
import kr.spring.member.vo.MemberVO;

@Service
@Transactional
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	MemberMapper memberMapper;

	@Override
	public void insertMember(MemberVO member) {
		member.setMem_num(memberMapper.selectMem_num());
		memberMapper.insertMember(member);
		memberMapper.insertMember_detail(member);
	}

	@Override
	public MemberVO selectCheckMember(String mem_id) {
		return memberMapper.selectCheckMember(mem_id);
	}

	@Override
	public void updateAu_id(String au_id, Long mem_num) {
		
	}

	@Override
	public void selectAu_id(String au_id) {
		
	}

	@Override
	public void deleteAu_id(Long mem_num) {
		
	}

	@Override
	public MemberVO selectCheckPMember(String mem_phone) {
		return memberMapper.selectCheckPMember(mem_phone);
	}

	@Override
	public MemberVO selectCheckEMember(String mem_email) {
		return memberMapper.selectCheckEMember(mem_email);
	}

	@Override
	public MemberVO findId(MemberVO member) {
		return memberMapper.findId(member);
	}

	@Override
	public MemberVO updateRandomPasswd(MemberVO member) {
		return memberMapper.updateRandomPasswd(member);
	}


	@Override
	public void updatePassword(String mem_passwd, String mem_id) {
		memberMapper.updatePassword(mem_passwd, mem_id);
	}

	@Override
	public void chargePoint(Long ph_point, Long mem_num,String ph_payment) {
		memberMapper.chargePoint(ph_point, mem_num,ph_payment);
	}

	@Override
	public List<Long> selectInitialCoupons() {
		return memberMapper.selectInitialCoupons();
	}

	@Override
	public void insertNewMemCoupon(CouponVO coupon) {
		memberMapper.insertNewMemCoupon(coupon);
	}

}
