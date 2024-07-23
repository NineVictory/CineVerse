package kr.spring.cinema.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.cinema.dao.CinemaMapper;
import kr.spring.cinema.dao.CinemaMapper2;
import kr.spring.cinema.vo.CinemaVO;
import kr.spring.cinema.vo.TheaterVO;
import kr.spring.cinema.vo.cMovieVO;
import kr.spring.movie.vo.MovieTimeVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.seat.vo.SeatVO;

@Service
@Transactional
public class CinemaServiceImpl2 implements CinemaService2{
 
	@Autowired
	CinemaMapper2 cinemaMapper2;

	@Override
	public List<cMovieVO> movieTimeForCinema(Long c_num, String mt_date) {
		return cinemaMapper2.movieTimeForCinema(c_num, mt_date);
	}


}
