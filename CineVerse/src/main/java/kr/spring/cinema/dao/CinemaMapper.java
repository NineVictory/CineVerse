package kr.spring.cinema.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.cinema.vo.CinemaVO;

@Mapper
public interface CinemaMapper {
	//영화관
	public List<CinemaVO> selectCinemaList(Map<String,Object>map);
	public Integer selectCinemaRowCount(Map<String,Object> map);
	public void insertCinema(CinemaVO cinema);
	public CinemaVO selectCinema(Long c_num);
	public void updateCinema(CinemaVO cinema);
	public void deleteCinema(Long c_num);
}
