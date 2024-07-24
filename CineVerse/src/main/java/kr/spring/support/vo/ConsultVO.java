package kr.spring.support.vo;

import java.sql.Clob;
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
public class ConsultVO {
	private long consult_num;
	@NotBlank
	private String consult_title;
	@NotEmpty
	private String consult_content;
	private Date consult_reg_date;
	private Date consult_modify_date;
	private int consult_status;
	private long mem_num;
	
	//테이블 컬럼 추가함
	private String consult_type;
	private MultipartFile c_upload;
	private String consult_file;
	private String consult_ip;
	@NotBlank
	private String consult_answer;
	
	//조인
	private Long order_num;//주문테이블 고유번호
	private String mem_id;
	private String od_number;
	/*
	 * public void setOrder_num(String order_num) { // 빈 문자열을 null로 처리 try {
	 * this.order_num = (order_num == null || order_num.trim().isEmpty()) ? null :
	 * Long.valueOf(order_num); } catch (NumberFormatException e) { // 로그 기록 또는 예외
	 * 처리 this.order_num = null; } }
	 */
}
