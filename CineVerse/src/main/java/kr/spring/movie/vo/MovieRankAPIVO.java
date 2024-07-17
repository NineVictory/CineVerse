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
	private String showRange;
	private String movieNm;
	private String movieCd;
	private String openDt;
	private String salesAmt;
	private String salesAcc;
	private String audiCnt;
	private String audiAcc;
}
