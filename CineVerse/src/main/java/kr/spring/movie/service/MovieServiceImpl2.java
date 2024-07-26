package kr.spring.movie.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.movie.dao.MovieMapper;
import kr.spring.movie.dao.MovieMapper2;
import kr.spring.movie.vo.MbDetailVO;
import kr.spring.movie.vo.MovieActorVO;
import kr.spring.movie.vo.MovieBookMarkVO;
import kr.spring.movie.vo.MovieBookingVO;
import kr.spring.movie.vo.MovieDetailKFAPIVO;
import kr.spring.movie.vo.MovieDirectorVO;
import kr.spring.movie.vo.MovieGenreVO;
import kr.spring.movie.vo.MovieReviewVO;
import kr.spring.movie.vo.MovieReviewfavVO;
import kr.spring.movie.vo.MovieTimeVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.seat.vo.SeatVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
@Transactional
public class MovieServiceImpl2 implements MovieService2 {
	
	@Autowired
	MovieMapper2 movieMapper;

	@Override
	public MovieTimeVO selectData(long m_code) {
		return movieMapper.selectData(m_code);
	}
	
}
