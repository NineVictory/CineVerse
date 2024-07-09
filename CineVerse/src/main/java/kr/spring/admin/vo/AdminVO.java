package kr.spring.admin.vo;

import java.sql.Clob;
import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AdminVO {
	//회원관리 
	private long mem_num;
	private long mem_auth;

	//맴버십관리
	private long mem_membership;
	private long ph_point; //포인트 돌려주기
	private Date ph_date; //포인트 날짜

	//공지사항관리
	private long nb_num;
	private String nb_title;
	private Clob nb_content;
	private Date re_reg_date;
	private String nb_filename;

	//이벤트관리
	private long event_num;
	private String event_name;
	private String event_filename;
	private Clob event_content;
	private String event_start;
	private String event_end;
	private Date event_reg_date;

	//결제취소
	private long ph_num; //위에 ph_point랑 ph_date잇음

}