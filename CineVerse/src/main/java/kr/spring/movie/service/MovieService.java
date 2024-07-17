package kr.spring.movie.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import kr.spring.board.vo.BoardFavVO;
import kr.spring.movie.vo.MovieBookMarkVO;
import kr.spring.movie.vo.MovieBookingVO;
import kr.spring.movie.vo.MovieReviewVO;
import kr.spring.movie.vo.MovieReviewfavVO;
import kr.spring.movie.vo.MovieTimeVO;
import kr.spring.movie.vo.MovieVO;

public interface MovieService {
    // 영화 목록 리스트
    List<MovieVO> selectMovieList(Map<String, Object> map);
    Integer selectMovieRowCount(Map<String, Object> map);
    void insertMovie(MovieVO movie);
    MovieVO selectMovie(long m_code);
    void updateMovie(MovieVO movie);
    void deleteMovie(Long m_code);
    
    // 영화 북마크
    MovieBookMarkVO selectBookMark(MovieBookMarkVO bookMark);
    Integer selectBookMarkCount(Long m_code);
    void insertBookMark(MovieBookMarkVO bookMark);
    void deleteBookMark(MovieBookMarkVO bookMark);
    
    // 영화시간 등록
    List<MovieVO> selectMovieTimeList(Map<String, Object> map);
    void insertMovieTime(MovieTimeVO movietime);
    
    
    
    
    // 영화 리뷰
    List<MovieReviewVO> selectMovieListReview(Map<String, Object> map);
    Integer selectMovieRowCountReview(Map<String, Object> map);
    MovieReviewVO selectReview(Long mr_num);
    void insertReview(MovieReviewVO movieReview);
    void updateReview(MovieReviewVO movieReview);
    void deleteReview(Long mr_num);
    
    //영화 리뷰 좋아요
    public MovieReviewfavVO selecReFav(MovieReviewfavVO fav);
	public Integer selectReFavCount(Long mr_num);
	public void insertReFav(MovieReviewfavVO fav);
	public void deleteReFav(MovieReviewfavVO fav);
    
    
    // 영화 시간표
    void addMovieTime(MovieTimeVO movieTimeVO);
    
    // 사용자가 해당 영화를 예매했는지 확인
    boolean canWriteReview(long mem_num, long m_code);
    MovieBookingVO getBookingInfo(long mem_num, long m_code);
    
    //영화예매
    void saveBooking(Long mb_price, Long mem_num, Long mt_num, Long m_code, String selectedSeats);


}
