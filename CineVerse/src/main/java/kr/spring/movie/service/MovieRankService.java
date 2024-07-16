package kr.spring.movie.service;

import java.util.List;

import kr.spring.movie.vo.MovieRankAPIVO;

public interface MovieRankService {
    void insertMovieRank(MovieRankAPIVO movieRankAPI);

    List<MovieRankAPIVO> getMovieRank();
    
    void updateMovieRank();
}
