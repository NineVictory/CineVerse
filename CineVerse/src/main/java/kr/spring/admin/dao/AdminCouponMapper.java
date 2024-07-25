package kr.spring.admin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.member.vo.CouponVO;
import kr.spring.util.PagingUtil;

@Mapper
public interface AdminCouponMapper {
	
	public void registerCoupon(CouponVO couponVO);
	public Integer memberCouponCount(Map<String, Object> map);
	
	public List<CouponVO> memberCouponList(Map<String, Object> map);
	
	public Integer CouponCount(Map<String, Object> map);
	public List<CouponVO> CouponList(Map<String, Object> map);
	
	@Select("SELECT * FROM coupon_db WHERE coupon_num=#{coupon_num}")
	public CouponVO couponDetail(Long coupon_num);
	
	public void modifyCoupon(CouponVO couponVO);
}
