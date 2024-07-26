package kr.spring.movie.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.movie.dao.MovieMapper;
import kr.spring.movie.vo.MbDetailVO;
import kr.spring.movie.vo.MovieActorVO;
import kr.spring.movie.vo.MovieBookMarkVO;
import kr.spring.movie.vo.MovieBookingVO;
import kr.spring.movie.vo.MovieDetailKFAPIVO;
import kr.spring.movie.vo.MovieDirectorVO;
import kr.spring.movie.vo.MovieGenreVO;
import kr.spring.movie.vo.MovieReviewReportReporterVO;
import kr.spring.movie.vo.MovieReviewReportVO;
import kr.spring.movie.vo.MovieReviewVO;
import kr.spring.movie.vo.MovieReviewfavVO;
import kr.spring.movie.vo.MovieTimeVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.seat.vo.SeatVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
@Transactional
public class MovieServiceImpl implements MovieService {
	
	@Autowired
	MovieMapper movieMapper;
	
	@Override
	public List<MovieVO> selectMovieList(Map<String, Object> map) {

		return movieMapper.selectMovieList(map);
	}
	
	@Override
	public List<MovieVO> selectMovieListCurrent(Map<String, Object> map) {
		
		return movieMapper.selectMovieListCurrent(map);
	}

	@Override
	public List<MovieVO> selectMovieListSchedule(Map<String, Object> map) {
		
		return movieMapper.selectMovieListSchedule(map);
	}

	@Override
	public Integer selectMovieRowCount(Map<String, Object> map) {

		return movieMapper.selectMovieRowCount(map);
	}

	@Override
	public void insertMovie(MovieVO movie) {
		
		movie.setM_code(movieMapper.selectM_code()); 
		movieMapper.insertMovie(movie);
		
	    log.debug("Inserting movie: {}", movie);
	    log.debug("Inserted movie genre: {}", movie.getM_genre());
		
		
		// movie_actor 테이블에 데이터 삽입
	    MovieActorVO actor = new MovieActorVO();
	    actor.setM_code(movie.getM_code());
	    actor.setActor(movie.getActor());
	    movieMapper.insertMovieActor(actor);
	    
	    // movie_director 테이블에 데이터 삽입
	    MovieDirectorVO director = new MovieDirectorVO();
	    director.setM_code(movie.getM_code());
	    director.setDirector(movie.getDirector());
	    movieMapper.insertMovieDirector(director);
	    
	    // movie_genre 테이블에 데이터 삽입
	    //MovieGenreVO genre = new MovieGenreVO();
	    //genre.setM_code(movie.getM_code());
	   // genre.setGenre(movie.getGenre());
	    //movieMapper.insertMovieGenre(genre);
	    
        // movie_genre 테이블에 데이터 삽입
		/*
		 * String genres = movie.getGenre(); if (genres != null && !genres.isEmpty()) {
		 * String[] genreArray = genres.split(","); for (String genre : genreArray) {
		 * MovieGenreVO movieGenre = new MovieGenreVO();
		 * movieGenre.setM_code(movie.getM_code()); movieGenre.setGenre(genre.trim());
		 * movieMapper.insertMovieGenre(movieGenre); } }
		 */
	    
	 // 영화 장르를 쉼표로 구분하여 movie_genre 테이블에 삽입
	    if (movie.getM_genre() != null) {
	        String[] genres = movie.getM_genre().split(",");
	        for (String genreName : genres) {
	            MovieGenreVO genre = new MovieGenreVO();
	            genre.setM_code(movie.getM_code());
	            genre.setGenre(genreName.trim());
	            movieMapper.insertMovieGenre(genre);
	        }
	    }
		
	}

	

	@Override
	public MovieVO selectMovie(long m_code) {
		
		return movieMapper.selectMovie(m_code);
	}

	@Override
	public void updateMovie(MovieVO movie) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteMovie(Long m_code) {

		//리뷰 좋아요 삭제
		movieMapper.deleteReFavByM_code(m_code);
	}

	@Override
	public MovieBookMarkVO selectBookMark(MovieBookMarkVO bookMark) {
		
		return movieMapper.selectBookMark(bookMark);
	}

	@Override
	public Integer selectBookMarkCount(Long m_code) {
		
		return movieMapper.selectBookMarkCount(m_code);
	}

	@Override
	public void insertBookMark(MovieBookMarkVO bookMark) {
		movieMapper.insertBookMark(bookMark);
		
	}

	@Override
	public void deleteBookMark(MovieBookMarkVO bookMark) {
		movieMapper.deleteBookMark(bookMark);
		
	}

	@Override
	public List<MovieReviewVO> selectMovieListReview(Map<String, Object> map) {

		return movieMapper.selectMovieListReview(map);
	}

	@Override
	public Integer selectMovieRowCountReview(Map<String, Object> map) {
		
		return movieMapper.selectMovieRowCountReview(map);
	}

	@Override
	public MovieReviewVO selectReview(Long mr_num) {
		return movieMapper.selectReview(mr_num);
	}

	@Override
	public void insertReview(MovieReviewVO movieReview) {
		movieMapper.insertReview(movieReview);
		
	}

	@Override
	public void updateReview(MovieReviewVO movieReview) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteReview(Long mr_num) {
		movieMapper.deleteReview(mr_num);
			
		//댓글 좋아요
		movieMapper.deleteReFavByMrnum(mr_num);
	}

	@Override
	public List<MovieVO> selectMovieTimeList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertMovieTime(MovieTimeVO movietime) {
		movieMapper.insertMovieTime(movietime);
	}



    
    @Override
    @Transactional
    public void addMovieTime(MovieTimeVO movieTimeVO) {
        movieMapper.addMovieTime(movieTimeVO);
    }

	@Override
	public boolean canWriteReview(long mem_num, long m_code) {
		return movieMapper.hasBookedMovie(mem_num, m_code) > 0;
	}

	@Override
	public MovieBookingVO getBookingInfo(long mem_num, long m_code) {
		return movieMapper.getBookingInfo(mem_num, m_code);
	}

	@Override
	public MovieReviewfavVO selecReFav(MovieReviewfavVO fav) {
		
		return movieMapper.selecReFav(fav);
	}

	@Override
	public Integer selectReFavCount(Long mr_num) {
		
		return movieMapper.selectReFavCount(mr_num);
	}

	@Override
	public void insertReFav(MovieReviewfavVO fav) {
		movieMapper.insertReFav(fav);
		
	}

	@Override
	public void deleteReFav(MovieReviewfavVO fav) {
		movieMapper.deleteReFav(fav);
		
	}

	@Override
	public void saveBooking(Long mb_price, Long mem_num, Long mt_num, Long m_code, String selectedSeats) {
        MovieBookingVO movieBooking = new MovieBookingVO();
        movieBooking.setMb_price(mb_price);
        movieBooking.setMem_num(mem_num);
        movieBooking.setMt_num(mt_num);
        movieBooking.setM_code(m_code);

        // MovieBooking 테이블에 예약 정보 저장
        movieMapper.insertBooking(movieBooking);

        // mb_detail 테이블에 좌석별 상세 예약 정보 저장
        String[] seats = selectedSeats.split(",");
        for (String seat : seats) {
            MbDetailVO mbDetail = new MbDetailVO();
            mbDetail.setMd_type(1);  // 예시로 사용, 실제로는 필요한 값 설정
            mbDetail.setMb_num(movieBooking.getMb_num());
            mbDetail.setSeat_num(Long.valueOf(seat));
            movieMapper.insertBookingDetail(mbDetail);
        }
    }

	@Override
	public List<String> selectDistinctGenres() {
		 return movieMapper.selectDistinctGenres();
	}

    @Override
    public List<MovieVO> filterMoviesByGenres(List<String> genres) {
        return movieMapper.filterMoviesByGenres(genres);
    }
	@Override
	public List<MovieVO> filterMoviesByGenres2(List<String> genres) {
		
		return movieMapper.filterMoviesByGenres2(genres);
	}
	
	@Override
	public List<MovieVO> filterMoviesByGenres3(List<String> genres) {
		
		return movieMapper.filterMoviesByGenres3(genres);
	}

	@Override
	public MovieDetailKFAPIVO selectDetailKFAPIVO(String title) {
		 return movieMapper.selectDetailKFAPIVO(title);
	}
    @Override
    public Long getMbNum() {
        return movieMapper.selectMb_num();
    }
	@Override
	public void insertBooking(MovieBookingVO movieBooking) {
		movieMapper.insertBooking(movieBooking);
		
	}
	
	@Override
	public void insertBookingDetail(MbDetailVO mbDetail) {
		mbDetail.setMd_num(movieMapper.selectMd_num());
		movieMapper.insertBookingDetail(mbDetail);
		
	}

	/*
	 * @Override public void usePoint(long ph_point, long mem_num) {
	 * movieMapper.usePoint(ph_point, mem_num); }
	 */
	
	@Override
	public void useCoupon(long mem_coupon_use, long mc_num) {
		movieMapper.useCoupon(mem_coupon_use, mc_num);
		
	}

	@Override
	public void insertPointHistory(long ph_point, long mem_num, int ph_type, String ph_payment) {
		movieMapper.insertPointHistory(ph_point, mem_num, ph_type, ph_payment);
		
	}

	@Override
	public MovieVO selectMovieDetail(Long m_code) {
		return movieMapper.selectMovieDetail(m_code);
	}

	@Override
	public void updateMemberPoint(long newPoint, long mem_num) {
		 movieMapper.updateMemberPoint(newPoint, mem_num);
		
	}

	@Override
	public List<SeatVO> seatBooking(long mt_num) {
		
		return movieMapper.seatBooking(mt_num);
	}

	@Override
	public void updateUserMbNum(long mb_num, String user_mb_num) {
		movieMapper.updateUserMbNum(mb_num, user_mb_num);
	}

	@Override
	public MovieReviewReportVO selectMovieReport(MovieReviewReportVO MovieReviewReport) {
		
		return movieMapper.selectMovieReport(MovieReviewReport);
	}

	@Override
	public void insertReviewReport(MovieReviewReportVO report) {
		movieMapper.insertReviewReport(report);
		 report.setRr_num(report.getRr_num());
	}

	@Override
	public void insertReviewReporter(MovieReviewReportReporterVO MovieReviewReportReporter) {
		
		movieMapper.insertReviewReporter(MovieReviewReportReporter);
		
	}








	/*
	 * @Override public void updateMemberPoint(long ph_point, long mem_num) {
	 * movieMapper.updateMemberPoint(ph_point, mem_num);
	 * 
	 * }
	 */




















	

	


	

	

}
