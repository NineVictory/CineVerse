package kr.spring.admin.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReplyVO {
	private long cc_num;
	private long mem_num;
	private long cb_num;
	private String cc_content;
	private Date cc_reg_date;
	private long cc_report;

	private String mem_name;
	private long te_num;
	private String te_content;
	private Date te_date;
	private long te_report;
	private String data_type;
}
