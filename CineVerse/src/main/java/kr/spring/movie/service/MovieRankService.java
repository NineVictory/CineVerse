package kr.spring.movie.service;

import java.util.List;

import kr.spring.movie.vo.MovieRankAPIVO;

public interface MovieRankService {
    public void insertMovieRank(MovieRankAPIVO movieRankAPI);

   public List<MovieRankAPIVO> getMovieRank(String showrange);
    
   public void updateMovieRank();
   
   public Integer getMovieRankCnt(String showrange);
}
