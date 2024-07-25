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
public class BoardReportVO {
	private long br_num;
	private String br_content;
	@NotNull
	private Integer br_category;
	private long mem_num;
	private long cb_num;
	private Date br_rdate;
}
