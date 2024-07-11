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
	
	

	private String p_name;
	private Integer p_category;
	private String p_content;
	private long p_price;
	private long p_quantity;
	private int p_status;
	private Date p_reg_date;
	private Date r_modify_date;
	private String p_filename;
	
	private MultipartFile p_upload;
	
}
