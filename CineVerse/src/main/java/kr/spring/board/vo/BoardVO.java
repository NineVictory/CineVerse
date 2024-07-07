package kr.spring.board.vo;

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
public class BoardVO {
	private long cb_num;
	private long mem_num;
	@NotBlank
	private String cb_title;
	@NotEmpty
	private String cb_content;
	private String cb_filename;
	private MultipartFile upload;	//파일
	@NotBlank
	private int cb_type;	//카테고리
	private Date cb_reg_date;
	private Date cb_modify_date;
	private int cb_report;
	private int cb_hit;				//조회수
	private String cb_ip;				//ip주소

	
	private String id;				//아이디
	
	private int re_cnt;				//댓글 개수
	private int fav_cnt;			//좋아요 개수
}
