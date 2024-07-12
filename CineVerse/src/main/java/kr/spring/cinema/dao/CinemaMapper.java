package kr.spring.cinema.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.cinema.vo.CinemaVO;

@Mapper
public interface CinemaMapper {
	//영화관
	public List<CinemaVO> selectCinemaList(Integer c_location);
	public Integer selectCinemaRowCount(Map<String,Object> map);
	public void insertCinema(CinemaVO cinema);
	@Select("SELECT * FROM cinema WHERE c_num=#{c_num}")
	public CinemaVO selectCinema(Long c_num);
	public void updateCinema(CinemaVO cinema);
	@Delete("DELETE FROM cinema WHERE c_num=#{c_num}")
	public void deleteCinema(Long c_num);
}
