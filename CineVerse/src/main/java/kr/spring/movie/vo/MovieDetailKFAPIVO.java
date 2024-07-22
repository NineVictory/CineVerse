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
	private String title;          // 영화명(필요)
    private String titleOrg;       // 원제
    private String directorNm;     // 감독명(필요)
    private String actorNm;        // 배우명(필요)
    private String nation;         // 제작 국가
    private String company;        // 제작사(필요)
    private String plot;           // 줄거리(필요)
    private String runtime;        // 상영시간(필요)
    private String rating;         // 관람등급(필요)
    private String genre;          // 장르(필요)
    private String keywords;      // 키워드
    private String repRlsDate;      // 개봉일(필요)
    private String posters;      // 포스터(필요)
    private String stlls;      // 스틸컷
    private String CodeNo;      // 영화 코드
    private String teasers;      // 티저 영상(필요)
}
