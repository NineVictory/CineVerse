package kr.spring.admin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.admin.vo.EventVO;
import kr.spring.admin.vo.EventVO2;
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
	
	@Delete("DELETE FROM member_coupon WHERE mc_num=#{mc_num}")
	public void deleteMemberCoupon(long mc_num);
	
	@Insert("INSERT INTO member_coupon (mc_num, coupon_num, mem_num) VALUES(member_coupon_seq.nextval, #{coupon_num}, #{mem_num})")
	public void couponSendMember(@Param(value="coupon_num") long coupon_num, @Param(value="mem_num") long mem_num);
	
	
	public void insertCrowd(EventVO2 eventVO2);
}
