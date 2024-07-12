package kr.spring.cinema.service;

import java.util.List;
import java.util.Map;

import kr.spring.cinema.vo.CinemaVO;

public interface CinemaService {
	//영화관
		public List<CinemaVO> selectCinemaList(Integer c_location);
		public Integer selectCinemaRowCount(Map<String,Object> map);
		public void insertCinema(CinemaVO cinema);
		public CinemaVO selectCinema(String c_branch);
		public void updateCinema(CinemaVO cinema);
		public void deleteCinema(Long c_num);
}
