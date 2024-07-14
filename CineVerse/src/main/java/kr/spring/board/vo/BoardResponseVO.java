package kr.spring.board.vo;

import kr.spring.util.DurationFromNow;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardResponseVO {
	private long te_num;
	private String te_content;
	private long te_parent_num;		// 부모번호
	private int te_depth;			// 깊이 숫자
	private String te_date;
	private String te_mdate;
	private String te_ip;
	private long cc_num;
	private long mem_num;
	private int te_report;
	
	private String mem_id;
	private String mem_nickname;
	private String parent_id;
	private String pnick_name;
	
	/*public void setTe_date(String te_date) {
		this.te_date = DurationFromNow.getTimeDiffLabel(te_date);
	}
	public void setTe_mdate(String te_mdate) {
		this.te_mdate = DurationFromNow.getTimeDiffLabel(te_mdate);
	}*/
}
