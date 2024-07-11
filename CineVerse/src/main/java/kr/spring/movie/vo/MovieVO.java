package kr.spring.movie.vo;

import java.sql.Clob;
import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MovieVO {
	private Long m_code;
	private String m_name;
	private Date m_opendate;
	private String m_companys;
	private Long m_status;
	private Clob m_filename;
}
