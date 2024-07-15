package kr.spring.movie.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
public class MovieBookingVO {
	private Long mb_num;
	private Date mb_date;
	private Long mb_price;
	private Long mem_num;
	private Long mt_num;
	private Long m_code;
}
