package kr.spring.movie.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MovieDetailApiVO {
	private String mad_moviecd;
	private String mad_movienm;
	private String mad_showtm;
	private String mad_opendt;
	private String mad_genrenm;
	private String mad_cast;
	private String mad_watchgradenm;
}
