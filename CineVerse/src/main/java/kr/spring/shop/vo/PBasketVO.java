package kr.spring.shop.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

// p_basket 테이블
@ToString
@Getter
@Setter
public class PBasketVO {
	private long pb_num;
	private long pb_quantity;
	private Date p_reg_date;
	private long p_num;
	private long mem_num;
}
