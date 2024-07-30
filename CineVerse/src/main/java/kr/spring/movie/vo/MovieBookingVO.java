package kr.spring.movie.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
public class MovieBookingVO {
	private String user_mb_num;
	private Long mb_num;
	private Date mb_date;
	private Long mb_price;
	private Long mem_num;
	private Long mt_num;
	private Long m_code;
	private String m_name;
	private String th_name;
	private String c_branch;
	private String seat_row;
	private int seat_column;
	private int mt_start;
	private int mt_end;
	private Date mt_date;
	private String m_filename;
	private int md_type;
	private String ph_payment;
	private int booking_count;
	private Long mem_coupon_use;
	private long mc_num;
}
