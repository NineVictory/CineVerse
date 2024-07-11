package kr.spring.shop.vo;

import java.sql.Date;


import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

// p_basket 테이블
@ToString
@Getter
@Setter
public class PBasketVO {
	private long pb_num;
	private long pb_quantity;
	private Date pb_reg_date;
	private long p_num;
	private long mem_num;
	
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
