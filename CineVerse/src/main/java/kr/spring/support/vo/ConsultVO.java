package kr.spring.support.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ConsultVO {
	private long consult_num;
	private String consult_title;
	private String consult_content;
	private Date consult_reg_date;
	private Date consult_modify_date;
	private int consult_status;
	private long mem_num;
	
	//추가
	private String consult_type;
	private String cinema;
	private String consult_file;
}
