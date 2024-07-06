package kr.spring.member.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PointVO {
	private Long ph_num;
	private Long ph_point;
	private Date ph_date;
	private Long mem_num;
}
