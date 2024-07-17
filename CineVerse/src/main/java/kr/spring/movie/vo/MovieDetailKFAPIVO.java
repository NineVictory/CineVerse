package kr.spring.movie.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MovieDetailKFAPIVO {
	private String DOCID;
	private String movieSeq;
	private String title;          // 영화명
    private String titleOrg;       // 원제
    private String directorNm;     // 감독명
    private String actorNm;        // 배우명
    private String nation;         // 제작 국가
    private String company;        // 제작사
    private String plot;           // 줄거리
    private String runtime;        // 상영시간
    private String rating;         // 관람등급
    private String genre;          // 장르
    private String keywords;      // 키워드
    private String repRlsDate;      // 개봉일
    private String posters;      // 포스터
}
