package kr.spring.support.vo;

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
	
	//조인
	private long od_number;
}
