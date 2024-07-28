package kr.spring.admin.vo;


import java.sql.Date;

import kr.spring.util.DurationFromNow;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReMovieVO {
	private long mr_num;
	private String mr_content;
	private Date mr_regdate;
	private long mr_spoiler;
	private long mr_grade;
	private long mb_num;
	private long m_code;
	private long mem_num;
	private String m_name;
	private int fav_cnt;
	
	private long rr_num;
	private String rr_type;
	private Date rr_reportdate;
	
	private String mem_id;			//아이디(조인의 의해서 만들어질것)
	private String mem_nickname;	//별명(조인의 의해서 만들어질것)
	
	private int review_count;
	//로그인 한 상태에서 클릭한 사람의 정보 읽기, 로그인하지 않으면 0 전달
	private int mr_click_num;
	private int review_cnt;		//댓글 좋아요 갯수
	//댓글 날짜를 하루전 한달전 등으로 바꿔주는 코드를 연결하는법
	/*
	 * public void setMr_regdate(String mr_regdate) { this.mr_regdate =
	 * DurationFromNow.getTimeDiffLabel(mr_regdate);
	 * 
	 * }
	 */
}
