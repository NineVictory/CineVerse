package kr.spring.assignment.vo;

import java.sql.Date;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.PositiveOrZero;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AssignVO {
	private long ab_num;
	@NotBlank
	private String ab_title;
	@NotBlank
	private String ab_content;
	private Date ab_reg_date;
	private Date ab_modify_date;
	@NotNull
	private Long ab_price;
	private long ab_hit;
	private long ab_status;
	
	@NotNull
	private MultipartFile ab_upload;
	private String ab_filename;
	private long mem_num;
	private String ab_ip;
	//추가
	@NotBlank
	private String ab_type;
	@NotNull
	private int ab_item_status;
	private long ab_report;

	private String mem_id;
	private String mem_nickname;
	
	private int ac_cnt;		//댓글수
	private int bookmark_cnt;	//북마크수
	
	//신고 report, 상태 status 나중에 추가?
	
	private int fav_cnt;
	
}
