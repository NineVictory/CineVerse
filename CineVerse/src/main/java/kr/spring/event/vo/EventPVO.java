package kr.spring.event.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EventPVO {
	private long ep_num;
	private long mem_num;
	private long event_num;
	private Date ep_date;
	private String ep_content;
	private long ep_type;
	private long event_type;
	private String crowd_movie;
}
