package kr.spring.admin.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FaqVO {
	private long f_num;
	private long mem_num;
	private String f_title;
	private String f_content;
	private Date f_reg_date;
	private Date modify_date;
	private String f_filename;
	private long f_hit;
	private MultipartFile f_upload;
}
