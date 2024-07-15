package kr.spring.cinema.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CinemaVO {
	private Long c_num;				//영화관 번호
	private String c_branch;		//지점명
	private String c_location;		//지역
	private String c_address;		//주소
	private String c_phone;			//전화번호
	private String c_parkable;		//주차 가능 여부
}
