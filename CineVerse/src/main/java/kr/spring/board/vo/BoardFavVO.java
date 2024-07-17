package kr.spring.board.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardFavVO {
	private long cb_num;
	private long mem_num;
	
	private String cb_type;
	private String cb_title;
	private Date cb_reg_date;
	private Date cb_modify_date;
	private int fav_cnt;
	
}