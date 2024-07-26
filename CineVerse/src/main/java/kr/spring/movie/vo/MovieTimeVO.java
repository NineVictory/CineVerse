package kr.spring.movie.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MovieTimeVO {
	private Long mt_num;
	private Date mt_date;
	private int mt_start;           //타입 String → int 로 변경 (sql 쪽도 number로 수정해야 함 아직 수정 못함)
	private int mt_end;				//타입 String → int 로 변경 (sql 쪽도 number로 수정해야 함 아직 수정 못함)
	private Long m_code;
	private Long th_num;
	private String rating;
	
	private String th_name;
	private String m_name;
	private String c_branch;
	private String m_filename; 
	
	private int c_location;
}
