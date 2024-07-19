package kr.spring.cinema.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.cinema.vo.CinemaVO;
import kr.spring.cinema.vo.TheaterVO;
import kr.spring.movie.vo.MovieTimeVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.seat.vo.SeatVO;

@Mapper
public interface CinemaMapper {
	
	//영화관
	public List<CinemaVO> selectCinemaList(Map<String,Object> map);
	public Integer selectCinemaCount(Map<String,Object> map);
	public void insertCinema(CinemaVO cinema);
	@Select("SELECT * FROM cinema WHERE c_num=#{c_num}")
	public CinemaVO selectCinema(Long c_num);
	public void updateCinema(CinemaVO cinema);
	@Delete("DELETE FROM cinema WHERE c_num=#{c_num}")
	public void deleteCinema(Long c_num);
	
 
	//상영관 
	public List<TheaterVO> selectTheaterListByCinemaNum(long c_num);
	public Integer selectTheaterCountByCinema(long c_num);
	
	//지점명에 해당하는 영화목록 조회
	public List<MovieVO> getMoviesByCinema(long c_num);
	
	//영화 시간표 목록 조회
	public List<MovieTimeVO> selectMovieTimeList(long c_num, long m_code, String mt_date);
	
	//좌석 선택 페이지에서 선택한 영화 및 지점명 정보 목록 조회
	public List<MovieTimeVO> selectAllInfoList(long mt_num);
	 
	//좌석 목록 조회
	public List<SeatVO> selectSeatList(long mt_num);
	
	
	//선택한 영화에 대한 좌석 목록 조회
	//public List<SeatVO> selectSeatList(long c_num, long m_code, String mt_date, String mt_start);
	
	
	//영화관 (잠시보류)
	//public List<CinemaVO> selectCinemaList(Integer c_location);
	//public Integer selectCinemaRowCount(Map<String,Object> map);
	//public void insertCinema(CinemaVO cinema);
	//public CinemaVO selectCinema(Long c_num);
	//public void updateCinema(CinemaVO cinema);
	//public void deleteCinema(Long c_num);
}
