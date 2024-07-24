package kr.spring.movie.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.movie.vo.MovieDetailKFAPIVO;
import kr.spring.movie.vo.MovieVO;

@Mapper
public interface MovieDetailMapper {
	public void insertMovieDetail(MovieDetailKFAPIVO movieDetail);
	@Select("SELECT e.*,m.rank FROM movie e INNER JOIN movie_rank_api m ON TRIM(e.m_name) = TRIM(m.movienm) WHERE m.showrange = #{showrange} ORDER BY TO_NUMBER(m.rank) ASC")
    public List<MovieVO>selectRankMovie(@Param("showrange") String showrange);
}
