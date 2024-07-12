package kr.spring.movie.vo;

import java.sql.Clob;
import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MovieReviewVO {
	private long mr_num;
	private Clob mr_content;
	private Date mr_regdate;
	private long mr_spoiler;
	private long mr_grade;
	private long md_num;
	private long m_code;
	private long mem_num;
}
