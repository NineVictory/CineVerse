package kr.spring.admin.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.admin.dao.AdminCouponMapper;
import kr.spring.admin.dao.AdminMapper;
import kr.spring.admin.vo.AdminVO;
import kr.spring.admin.vo.EventVO;
import kr.spring.admin.vo.EventVO2;
import kr.spring.admin.vo.FaqVO;
import kr.spring.admin.vo.NoticeVO;
import kr.spring.admin.vo.RefundMbVO;
import kr.spring.admin.vo.ReplyVO;
import kr.spring.assignment.vo.AssignVO;
import kr.spring.board.vo.BoardCommentVO;
import kr.spring.board.vo.BoardVO;
import kr.spring.cinema.vo.CinemaVO;
import kr.spring.cinema.vo.TheaterVO;
import kr.spring.member.dao.MemberMapper;
import kr.spring.member.vo.CouponVO;
import kr.spring.member.vo.PointVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.support.vo.ConsultVO;
import lombok.extern.slf4j.Slf4j;
@Service
@Transactional
@Slf4j
public class AdminCouponServiceImpl implements AdminCouponService{
	@Autowired
	AdminCouponMapper couponMapper;

	@Override
	public void registerCoupon(CouponVO couponVO) {
		couponMapper.registerCoupon(couponVO);
		
	}

	@Override
	public List<CouponVO> memberCouponList(Map<String, Object> map) {
		return couponMapper.memberCouponList(map);
	}

	@Override
	public Integer memberCouponCount(Map<String, Object> map) {
		return couponMapper.memberCouponCount(map);
	}

	@Override
	public Integer CouponCount(Map<String, Object> map) {
		return couponMapper.CouponCount(map);
	}

	@Override
	public List<CouponVO> CouponList(Map<String, Object> map) {
		return couponMapper.CouponList(map);
	}

	@Override
	public CouponVO couponDetail(Long coupon_num) {
		return couponMapper.couponDetail(coupon_num);
	}

	@Override
	public void modifyCoupon(CouponVO couponVO) {
		couponMapper.modifyCoupon(couponVO);
	}

	@Override
	public void deleteMemberCoupon(long mc_num) {
		couponMapper.deleteMemberCoupon(mc_num);
	}

	@Override
	public void couponSendMember(long coupon_num, long mem_num) {
		couponMapper.couponSendMember(coupon_num, mem_num);
	}

	@Override
	public void insertCrowd(EventVO2 eventVO2) {
		couponMapper.insertCrowd(eventVO2);
	}

}
