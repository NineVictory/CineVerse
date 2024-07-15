package kr.spring.seat.service;

import java.util.List;
import java.util.Map;

import kr.spring.seat.vo.SeatVO;

public interface SeatService {
	//좌석
		public List<SeatVO> selectSeatList(Map<String,Object>map);
		public Integer selectSeatRowCount(Map<String,Object> map);
		public void insertSeat(SeatVO seat);
		public SeatVO selectSeat(Long seat_num);
		public void updateSeat(SeatVO seat);
		public void deleteSeat(Long seat_num);
}
