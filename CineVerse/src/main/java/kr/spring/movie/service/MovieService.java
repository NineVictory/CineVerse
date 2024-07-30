package kr.spring.movie.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.board.vo.BoardFavVO;
import kr.spring.movie.vo.MbDetailVO;
import kr.spring.movie.vo.MovieBookMarkVO;
import kr.spring.movie.vo.MovieBookingVO;
import kr.spring.movie.vo.MovieDetailKFAPIVO;
import kr.spring.movie.vo.MovieReviewReportReporterVO;
import kr.spring.movie.vo.MovieReviewReportVO;
import kr.spring.movie.vo.MovieReviewVO;
import kr.spring.movie.vo.MovieReviewfavVO;
import kr.spring.movie.vo.MovieTimeVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.seat.vo.SeatVO;

public interface MovieService {
    // 영화 목록 리스트
    List<MovieVO> selectMovieList(Map<String, Object> map);
	public List<MovieVO> selectMovieListCurrent(Map<String,Object>map);
	public List<MovieVO> selectMovieListSchedule(Map<String,Object>map);
    Integer selectMovieRowCount(Map<String, Object> map);
    void insertMovie(MovieVO movie);
    MovieVO selectMovie(long m_code);
    void updateMovie(MovieVO movie);
    void deleteMovie(Long m_code);
    
    public MovieVO selectMovieDetail(Long m_code);
    
    public List<String> selectDistinctGenres();
    public List<MovieVO> filterMoviesByGenres(List<String> genres);
    List<MovieVO> filterMoviesByGenres2(@Param("genres") List<String> genres);
    List<MovieVO> filterMoviesByGenres3(@Param("genres") List<String> genres);
    MovieDetailKFAPIVO selectDetailKFAPIVO(String title);
    
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
    //영화 리뷰 신고
	public MovieReviewReportVO selectMovieReport(MovieReviewReportVO MovieReviewReport);
	public void insertReviewReport(MovieReviewReportVO MovieReviewReport);
	public void insertReviewReporter(MovieReviewReportReporterVO MovieReviewReportReporter);   
	public Integer checkDuplicateReport(Long mr_num,Long mem_num);

	/* public List<MovieReviewVO> selectVisibleReviews(Long m_code); */
	public List<Long> getHiddenReviewIds();
	
    // 영화 시간표
    void addMovieTime(MovieTimeVO movieTimeVO);
    
    // 사용자가 해당 영화를 예매했는지 확인
    boolean canWriteReview(long mem_num, long m_code);
    MovieBookingVO getBookingInfo(long mem_num, long m_code);
    
    //영화예매
    void saveBooking(Long mb_price, Long mem_num, Long mt_num, Long m_code, String selectedSeats);
    Long getMbNum();
    void insertBooking(MovieBookingVO movieBooking);
    void insertBookingDetail(MbDetailVO mbDetail);
    void insertPointHistory(long ph_point, long mem_num, int ph_type, String ph_payment);
    int checkDuplicateBooking(@Param("mem_num") long mem_num, @Param("mt_num") long mt_num, @Param("seatNums") String seatNumStr);
	/* void updateMemberPoint(long ph_point, long mem_num); */
	/* void usePoint(long ph_point, long mem_num); */
    void updateMemberPoint(long newPoint, long mem_num);
    void useCoupon(long mem_coupon_use, long mc_num);
    
    public List<SeatVO> seatBooking(long mt_num);
    public void updateUserMbNum(@Param("mb_num") long mb_num, @Param("user_mb_num") String user_mb_num);
}
