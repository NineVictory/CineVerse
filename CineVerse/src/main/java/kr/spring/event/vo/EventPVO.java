package kr.spring.event.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

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
	private MultipartFile event_upload;	//파일
/*	private String crowd_movie1;
	private String crowd_movie2;
	private String crowd_movie3;
	private String crowd_movie4;*/
}
