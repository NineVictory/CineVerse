package kr.spring.shop.vo;

import java.sql.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

// product, product_review, fav_product 테이블
@ToString
@Setter
@Getter
public class ProductVO {
	// product
	private long p_num;
	@NotBlank
	private String p_name;
	@NotNull
	private Integer p_category;
	@NotBlank
	private String p_content;
	@NotNull
	private long p_price;
	@NotNull
	private long p_quantity;
	
	@NotNull
	private int p_status;
	
	private Date p_reg_date;
	private Date p_modify_date;
	private String p_filename;
	
	@NotNull
	private MultipartFile p_upload;
	
	// product_review (p_num은 알아서 사용)
	private long pr_num;
	private String pr_content;
	private Date pr_reg_date;
	private String pr_filename;
	private long od_num;
	private int pr_grade;
	
	// fav_product (p_num은 알아서 사용)
	private long mem_num;
	
	private long pb_num;
	private long pb_quantity;
	private Date pb_reg_date;

}
