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
	private String cn_content;
	private Date cc_reg_date;
	private long cc_report;

	private long th_num;
	private String th_content;
	private Date th_date;
	private long th_report;
}
