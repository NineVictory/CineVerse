package kr.spring.support.vo;

import java.sql.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserFaqVO {
	private long f_num;
	private String f_title;
	private String f_content;
	private Date f_reg_date;
	private Date f_modify_date;
	private MultipartFile f_upload;
	private String f_filename;
	private int f_hit;
	private long mem_num;
	

}
