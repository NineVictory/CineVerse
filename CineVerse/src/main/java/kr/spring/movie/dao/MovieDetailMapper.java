package kr.spring.movie.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.movie.vo.EMovieVO;
import kr.spring.movie.vo.MovieDetailKFAPIVO;

@Mapper
public interface MovieDetailMapper {
	public void insertMovieDetail(MovieDetailKFAPIVO movieDetail);
	@Select("SELECT e.*,m.rank FROM e_movie e INNER JOIN movie_rank_api m ON TRIM(e.em_title) = TRIM(m.movienm) WHERE m.showrange = #{showrange} ORDER BY TO_NUMBER(m.rank) ASC")
    public List<EMovieVO> selectRankMovie(@Param("showrange") String showrange);
}
