package kr.spring.cinema.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.cinema.vo.CinemaVO;
import kr.spring.cinema.vo.TheaterVO;
import kr.spring.cinema.vo.cMovieVO;
import kr.spring.movie.vo.MovieTimeVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.seat.vo.SeatVO;

@Mapper
public interface CinemaMapper2 {
	/*
	 * @Select("SELECT * FROM movie_time JOIN theater USING(th_num) JOIN movie USING(m_code) WHERE c_num = #{c_num} AND mt_date = #{mt_date} ORDER BY m_name ASC, mt_start ASC"
	 * )
	 */
	public List<cMovieVO> movieTimeForCinema(@Param(value="c_num") Long c_num, @Param(value="mt_date") String mt_date);
}
