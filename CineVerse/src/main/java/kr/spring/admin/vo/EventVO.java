package kr.spring.admin.vo;

import java.sql.Date;

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
	@NotNull
	private String event_name;
	@NotNull
	private MultipartFile upload;	//파일
	@NotNull
	private String event_filename;
	@NotNull
	private String event_content;
	@NotNull
	private Date event_start;
	@NotNull
	private Date event_end;
	private Date event_reg_date;
	private Date event_modify_date;
}
