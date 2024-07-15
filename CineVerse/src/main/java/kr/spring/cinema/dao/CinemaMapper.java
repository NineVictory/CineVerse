package kr.spring.cinema.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.cinema.vo.CinemaVO;
import kr.spring.cinema.vo.TheaterVO;

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
	public List<TheaterVO> selectTheaterList(Map<String,Object> map);
	public Integer selectTheaterCount(Map<String,Object> map);
	public void insertTheater(TheaterVO theater);
	public TheaterVO selectTheater(Long th_num);
	public void updateTheater(TheaterVO theater);	
	public void deleteTheater(Long th_num);
	
	
	//영화관 (잠시보류)
	//public List<CinemaVO> selectCinemaList(Integer c_location);
	//public Integer selectCinemaRowCount(Map<String,Object> map);
	//public void insertCinema(CinemaVO cinema);
	//public CinemaVO selectCinema(Long c_num);
	//public void updateCinema(CinemaVO cinema);
	//public void deleteCinema(Long c_num);
}
