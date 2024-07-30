package kr.spring.event.vo;

import java.sql.Date;

import javax.validation.constraints.NotBlank;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserEventVO {
	private long event_num;
	private String event_name;
	private String event_filename;
	private String event_content;
	private String event_start;
	private String event_end;
	private Date event_reg_date;
	private Date event_modify_date;
	private String ep_content;
	//추가
	private String event_type;
	private int ep_type;
	//
	private long t_rest;	//dday
	private int event_drawn;
	private int ep_result;
	private MultipartFile event_upload;	//파일
	private String crowd_movie1;
	private String crowd_movie2;
	private String crowd_movie3;
	private String crowd_movie4;
}
