package kr.spring.seat.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SeatReviewVO {
	private Long sr_num;			//좌석 리뷰 번호
	private String sr_content;		//리뷰 내용
	private Long md_num;			//영화 예매 내역 번호(예매했던 사람만 좌석 리뷰 작성 가능)
	private Long seat_num;			//좌석 번호
}
