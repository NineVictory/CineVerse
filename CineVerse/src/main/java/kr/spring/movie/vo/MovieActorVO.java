package kr.spring.movie.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MovieActorVO {
	private Long m_code;	//영화배우
	private String actor;	//배우이름
}
