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
	private String event_type;
	private long event_drawn;
	
	private long ep_num; // 신청자 식별 번호
	private long mem_num;	// 신청자 mem_num
	private Date ep_date; // 신청 접수 날짜
	private String ep_content; // 이벤트 신청했을 때 적는 정보
	private long ep_result; // 이벤트 결과
	private String mem_id;	// 신청한 사람의 아이디
	private long ep_type;
}
