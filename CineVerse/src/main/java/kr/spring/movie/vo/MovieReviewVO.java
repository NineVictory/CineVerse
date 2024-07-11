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
	private Long mr_num;
	private Clob mr_content;
	private Date mr_regdate;
	private Long mr_spoiler;
	private Long mr_grade;
	private Long md_num;
	private Long m_code;
}
