package kr.spring.shop.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

// orders, order_detail, order_change 테이블
@ToString
@Getter
@Setter
public class OrdersVO {
	// order 
	private long order_num;
	private long mem_num;
	private Date order_date;
	private int order_status;
	private long a_num;
	private String od_number;
	
	// order_detail (order_num 알아서 쓰기)
	private long od_num;
	private long order_quantity;
	private int od_review_status;
	private long p_num;
	 
	// order_change (order_num 알아서 쓰기)
	private long oc_num;
	private int oc_type;
	private String oc_content;
	private Date oc_reg_date;
	private int oc_confirm;
	private String oc_filename;
	
	private Long ph_num;
	private Long ph_point;
	private Date ph_date;
	private String ph_payment;
	private int ph_type;
	
	private long mc_num;		// 회원의 쿠폰 번호
	private int coupon_use;		// 회원 쿠폰 사용 여부 1:미사용, 2:사용, 3:만기
	private long coupon_num;	// 쿠폰의 번호
	private Date coupon_regdate;	// 쿠폰 발급일자
	
	private String coupon_name;		// 쿠폰 이름
	private String coupon_content;	// 쿠폰 내용
	private int coupon_type;		// 1:금액 할인 , 2:퍼센트 할
	private int coupon_sale;		// 할인 금액
	private int coupon_where;		// 어디서 사용 가능한지 1:영화 2:벌스샵
	

	private String p_name;
	private Integer p_category;
	private String p_content;
	private long p_price;
	private long p_quantity;
	private int p_status;
	private Date p_reg_date;
	private Date r_modify_date;
	private String p_filename;
	
	private long pb_quantity;
	
	private MultipartFile p_upload;
	
	// 주문 시 쓰는 것
	private long total;
	private int agree;
	
	private int total_quantity;
	private int total_price;
	
}
