package kr.spring.admin.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

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
import kr.spring.member.vo.CouponVO;
import kr.spring.member.vo.PointVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.support.vo.ConsultVO;

public interface AdminCouponService {
	public void registerCoupon(CouponVO couponVO);
	public Integer memberCouponCount(Map<String, Object> map);
	public List<CouponVO> memberCouponList(Map<String, Object> map);

	public Integer CouponCount(Map<String, Object> map);
	public List<CouponVO> CouponList(Map<String, Object> map);
	public CouponVO couponDetail(Long coupon_num);
	public void modifyCoupon(CouponVO couponVO);
	public void deleteMemberCoupon(long mc_num);
	public void couponSendMember(@Param(value="coupon_num") long coupon_num, @Param(value="mem_num") long mem_num);
	
	public void insertCrowd(EventVO2 eventVO2);
	public List<EventVO2> crowdParticipants(long event_num);
	public Integer cpCount(long event_num);
	
	public EventVO2 eventDetail(long event_num);
	public Integer m1Count(long event_num);
	public Integer m2Count(long event_num);
	public Integer m3Count(long event_num);
	public Integer m4Count(long event_num);
}	
