package kr.spring.movie.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MovieRankAPIVO {
	private String rnum;
	private String rank;
	private String showrange;
	private String movienm;
	private String moviecd;
	private String opendt;
	private String salesamt;
	private String salesacc;
	private String audicnt;
	private String audiacc;
}
