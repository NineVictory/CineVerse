package kr.spring.seat.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.seat.dao.SeatMapper;
import kr.spring.seat.vo.SeatVO;

@Service
@Transactional
public class SeatServiceImpl implements SeatService{

	@Autowired
	SeatMapper seatMapper;
	
	@Override
	public List<SeatVO> selectSeatList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer selectSeatRowCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertSeat(SeatVO seat) {
		seatMapper.insertSeat(seat);
	}

	@Override
	public SeatVO selectSeat(Long seat_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateSeat(SeatVO seat) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteSeat(Long seat_num) {
		// TODO Auto-generated method stub
		
	}

}
