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
public class UserNoticeVO {
	private long nb_num;
	private String nb_title;
	private String nb_content;
	private Date nb_reg_date;
	private Date nb_modify_date;
	private MultipartFile nb_upload;
	private String nb_filename;
	private int nb_hit;
	private long mem_num;
}
