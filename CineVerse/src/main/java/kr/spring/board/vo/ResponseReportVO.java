package kr.spring.board.vo;

import java.sql.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ResponseReportVO {
	private long rr_num;
	private String rr_content;
	@NotNull
	private Integer rr_category;
	private long mem_num;
	private long te_num;
	private Date rr_rdate;
}
