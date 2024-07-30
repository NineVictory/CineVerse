package kr.spring.admin.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
public class RefundMbVO {
	private Long mb_num;
	private Date mb_date;
	private Long mb_price;
	private Long mem_num;
	private Long mt_num;
	private Long m_code;
	private String m_name;
	private String th_name;
	private String c_branch;
	private String mem_id;
	private Long md_num;		//영화 예매 내역 번호
	private int md_type;		//예매 상태(1: 예매 2: 취소)
	private Long seat_num;		//좌석 번호
	private Long totalMb;
}
