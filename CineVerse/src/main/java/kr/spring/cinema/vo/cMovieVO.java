package kr.spring.cinema.vo;

import java.sql.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class cMovieVO {
	private Long c_num;				//영화관 번호
	private String c_branch;		//지점명
	private String c_location;		//지역
	private String c_address;		//주소
	private String c_phone;			//전화번호
	private String c_parkable;		//주차 가능 여부
	private long cm_id;
	private long m_code;
	private Long th_num;
	private String th_name;
	private String th_position;
	private String m_name;// 영화명
	private Long mt_num;
	private Date mt_date;
	private String mt_start;
	private String mt_end;
	private String m_filename; 
}
