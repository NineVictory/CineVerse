package kr.spring.movie.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MovieBookMarkVO {
	private Long mem_num;
	private Long m_code;
	
	private String m_name;
	private String m_filename;
}
