package kr.spring.movie.vo;


import java.sql.Date;

import kr.spring.util.DurationFromNow;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MovieReviewVO {
	private long mr_num;
	private String mr_content;
	private String mr_regdate;
	private long mr_spoiler;
	private long mr_grade;
	private long md_num;
	private long m_code;
	private long mem_num;
	
	
	//댓글 날짜를 하루전 한달전 등으로 바꿔주는 코드를 연결하는법
		public void setRe_date(String re_date) {
			this.mr_regdate = DurationFromNow.getTimeDiffLabel(mr_regdate);
			
		}
}
