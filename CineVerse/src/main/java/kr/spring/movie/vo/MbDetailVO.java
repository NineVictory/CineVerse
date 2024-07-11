package kr.spring.movie.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MbDetailVO {
	private Long md_num;		//영화 예매 내역 번호
	private int md_type;		//예매 상태(1: 예매 2: 취소)
	private Long mb_num;		//영화 예매 번호
	private Long seat_num;		//좌석 번호
}
