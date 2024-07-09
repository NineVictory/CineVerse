package kr.spring.assignment.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AssignVO {
	private long ab_num;
	private String ab_title;
	private String ab_content;
	private Date ab_reg_date;
	private Date ab_modify_date;
	private long ab_price;
	private long ab_hit;
	private long ab_status;
	private MultipartFile upload;
	private String ab_filename;
	private long mem_num;
	private String ab_ip;
	

	private String mem_id;
	
	private int ac_cnt;		//댓글수
	private int bookmark_cnt;	//북마크수
	
	//신고 report, 상태 status
}