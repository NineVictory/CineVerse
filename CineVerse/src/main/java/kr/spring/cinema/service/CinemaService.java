package kr.spring.cinema.service;

import java.util.List;
import java.util.Map;

import kr.spring.cinema.vo.CinemaVO;
import kr.spring.cinema.vo.TheaterVO;
import kr.spring.movie.vo.MovieTimeVO;

public interface CinemaService {
	
	//영화관
	public List<CinemaVO> selectCinemaList(Map<String,Object> map);
	public Integer selectCinemaCount(Map<String,Object> map);
	public void insertCinema(CinemaVO cinema);
	public CinemaVO selectCinema(Long c_num);
	public void updateCinema(CinemaVO cinema);
	public void deleteCinema(Long c_num);


	//상영관
	public Integer selectTheaterCount(Map<String,Object> map);
	public void insertTheater(TheaterVO theater);
	public TheaterVO selectTheater(Long th_num);
	public void updateTheater(TheaterVO theater);	
	public void deleteTheater(Long th_num);

	public List<TheaterVO> selectTheaterListByCinemaNum(long c_num);
	public Integer selectTheaterCountByCinema(long c_num);
	
	//상영 시간표 목록
	public List<MovieTimeVO> selectMovieTimesByMovieAndTheater(long m_code, long th_num);
	
	
		//영화관(잠시 보류)
		//public List<CinemaVO> selectCinemaList(Integer c_location);
		//public Integer selectCinemaRowCount(Map<String,Object> map);
		//public void insertCinema(CinemaVO cinema);
		//public CinemaVO selectCinema(Long c_num);
		//public void updateCinema(CinemaVO cinema);
		//public void deleteCinema(Long c_num);
}
