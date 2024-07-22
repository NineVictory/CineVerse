package kr.spring.event.vo;

import java.sql.Date;

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
	
	//추가
	private String event_type;
	
	//
	private long t_rest;
}
