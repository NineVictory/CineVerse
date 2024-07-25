package kr.spring.assignment.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AssignReportVO {
	private long ar_num;
	private String ar_content;
	private int ar_category;
	private long mem_num;
	private long ab_num;
	private Date ar_rdate;
}
