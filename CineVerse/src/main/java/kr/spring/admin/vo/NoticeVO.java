package kr.spring.admin.vo;

import java.sql.Clob;
import java.sql.Date;

import javax.validation.constraints.NotBlank;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoticeVO {
	//공지사항관리
	private long nb_num;
	@NotBlank
	private String nb_title;
	@NotBlank
	private String nb_content;
	private Date nb_reg_date;
	private Date nb_modify_date;
	private String nb_filename;
	private long nb_hit;
	private long mem_num;
	private MultipartFile nb_upload;	//파일
}
