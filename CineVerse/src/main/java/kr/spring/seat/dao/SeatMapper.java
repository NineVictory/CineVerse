package kr.spring.seat.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.seat.vo.SeatReviewVO;
import kr.spring.seat.vo.SeatVO;

@Mapper
public interface SeatMapper {
	//좌석
	public List<SeatVO> selectSeatList(Map<String,Object>map);
	public Integer selectSeatRowCount(Map<String,Object> map);
	public void insertSeat(SeatVO seat);
	public SeatVO selectSeat(Long seat_num);
	public void updateSeat(SeatVO seat);
	public void deleteSeat(Long seat_num);
	
	//좌석 리뷰
	public List<SeatReviewVO> selectListSeatReview(Map<String, Object> map);
	public Integer selectRowCountSeatReview(Map<String, Object> map);
	public SeatReviewVO selectSeatReview(Long sr_num);
	public void insertSeatReview(SeatReviewVO seatReview);
	public void updateseatReview(SeatReviewVO seatReview);
	public void deleteseatReview(Long sr_num);
	////좌석 삭제 시 좌석 리뷰가 존재하면 좌석 삭제 전 좌석 리뷰 삭제
	public void deleteReviewSeatNum(Long seat_num);
}

