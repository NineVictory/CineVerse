package kr.spring.admin.vo;

import java.sql.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.NotNull;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EventVO {
	//이벤트관리
	private long event_num;
	@NotBlank
	private String event_name;
	private String event_filename;
	@NotBlank
	private String event_content;
	@NotBlank
	private String event_start;
	@NotBlank
	private String event_end;
	private Date event_reg_date;
	private Date event_modify_date;
	private MultipartFile event_upload;	//파일
}
