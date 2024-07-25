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
public class CommentReportVO {
	private long cr_num;
	private String cr_content;
	@NotNull
	private Integer cr_category;
	private long mem_num;
	private long cc_num;
	private Date cr_rdate;
}
