package kr.spring.movie.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MovieApiVO {
	private String ma_code;
	private String ma_name;
	private String ma_madeyear;
	private String ma_opendate;
	private String ma_repgenre;
	private String ma_allgenre;
}
