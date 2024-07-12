package kr.spring.movie.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MovieTimeVO {
	private long mt_num;
	private Date mt_date;
	private String mt_start;
	private String mt_end;
	private Long m_code;
	private long c_num;
}
