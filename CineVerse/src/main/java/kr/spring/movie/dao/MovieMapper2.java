package kr.spring.movie.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.movie.vo.MovieTimeVO;
import kr.spring.movie.vo.MovieVO;

@Mapper
public interface MovieMapper2 {
	
	@Select("SELECT mt_date, c_location FROM (SELECT mt_date, c_location FROM movie_time JOIN theater USING (th_num) JOIN cinema USING (c_num) WHERE m_code = #{m_code} AND mt_date >= TRUNC(SYSDATE) ORDER BY mt_date ASC) WHERE ROWNUM = 1")
	public MovieTimeVO selectData(long m_code);

}
 