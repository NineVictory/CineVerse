package kr.spring.cinema.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TheaterVO {
	private Long th_num;
	private String th_name;
	private String th_position;
	private Long c_num;
	
	private String c_branch; //어디 지점에 상영관을 등록/조회할건지 확인을 위해 추가
	
    private List<TheaterVO> theaterList;
}
