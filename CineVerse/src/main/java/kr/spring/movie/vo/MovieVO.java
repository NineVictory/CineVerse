package kr.spring.movie.vo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MovieVO {
	private long m_code;
	@NotBlank
	private String m_name;// 영화명
	private String m_opendate;// 개봉일
	@NotBlank
	private String m_companys;// 제작사
	private long m_status;// 상영여부
	private String m_filename;// 포스터
	private String m_content;// 티저
	private String plot;// 줄거리
	private String m_genre;// 장르
	private String runtime;// 런타임
	private String rating;// 관람등급
	@NotNull
	private MultipartFile m_upload; // 파일

	private String actor;// 배우명
	private String m_actor;// api의 배우명
	private String director;// 감독명
	private String m_director;// api의 감독명
	private String genre;// 장르(쉼표로 구분한것)
	private String still; // 스틸컷

	private int bookmark_cnt; // 북마크 개수
	
	private String rank; // 영화 랭킹
	private int mr_grade;
	private String movie_rank; // 영화 랭킹(메인)
	private String reservation_rate;	// 영화 예매율(메인)
	private String average_grade;	// 각 영화의 리뷰평점
}
