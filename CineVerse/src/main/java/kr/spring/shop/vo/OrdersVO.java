package kr.spring.shop.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

// orders, order_detail, order_change 테이블
@ToString
@Getter
@Setter
public class OrdersVO {
	// order 
	private long order_name;
	private long mem_num;
	private Date order_date;
	private int order_status;
	private long a_num;
	
	// order_detail (order_num 알아서 쓰기)
	private long od_num;
	private long order_quantity;
	private int od_review_status;
	private int p_num;
	 
	// order_change (order_num 알아서 쓰기)
	private long oc_num;
	private int oc_type;
	private String oc_content;
	private Date oc_reg_date;
	private int oc_confirm;
	private String oc_filename;
	
}
