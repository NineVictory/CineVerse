package kr.spring.board.vo;

import kr.spring.util.DurationFromNow;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardCommentVO {
	private long cc_num;
	private String cc_content;
	private String cc_reg_date;
	private String cc_modify_date;
	private String cc_ip;
	private long cb_num;		//부모글 번호
	private long mem_num;		//작성자 회원번호
	
	// 조인에 의해 만들어지는 것
	private String mem_id;			//아이디				
	private String mem_nickname;	//별명
	
	//댓글 좋아요 작업
	//로그인 한 상태에서 클릭한 사람의 정보 읽기, 로그인하지 않으면 0 전달
	private int click_num;
	private int refav_cnt;		//댓글 좋아요 개수
	
	//답글 작업
	private int resp_cnt;		//답글 개수
	
	private String cb_type;
    private String cb_title;
    private int fav_cnt;
    
	public void setRe_date(String cc_reg_date) {
		this.cc_reg_date = DurationFromNow.getTimeDiffLabel(cc_reg_date);
	}
	public void setRe_mdate(String cc_modify_date) {
		this.cc_modify_date = DurationFromNow.getTimeDiffLabel(cc_modify_date);
	}
}
