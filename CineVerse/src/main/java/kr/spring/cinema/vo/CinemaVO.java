package kr.spring.cinema.vo;

import java.sql.Clob;

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
	private int c_theater;  		//상영관 수
	private int c_seat; 			//좌석 수
	private String c_parkable;		//주차 가능 여부
	private Clob c_filename;		//영화관 내부 사진
}
