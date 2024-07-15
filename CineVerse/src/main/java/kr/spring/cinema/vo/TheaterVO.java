package kr.spring.cinema.vo;

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
}
