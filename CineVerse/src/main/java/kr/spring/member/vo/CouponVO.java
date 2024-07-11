package kr.spring.member.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CouponVO {
	private long mc_num;		// 회원의 쿠폰 번호
	private int coupon_use;		// 회원 쿠폰 사용 여부 1:미사용, 2:사용, 3:만기
	private long coupon_num;	// 쿠폰의 번호
	private long mem_num;		// 회원 번호
	private Date coupon_regdate;	// 쿠폰 발급일자
	
	private String coupon_name;		// 쿠폰 이름
	private String coupon_content;	// 쿠폰 내용
	private int coupon_type;		// 1:금액 할인 , 2:퍼센트 할
	private int coupon_sale;		// 할인 금액
	private int coupon_where;		// 어디서 사용 가능한지 1:영화 2:벌스샵
}
