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
	private String mt_start;
	private String mt_end;
	private Long m_code;
	private Long th_num;
	
	private String th_name;
	private String m_name;
	private String c_branch;
	private String m_filename; 
}
