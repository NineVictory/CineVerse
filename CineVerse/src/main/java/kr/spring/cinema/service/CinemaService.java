package kr.spring.cinema.service;

import java.util.List;
import java.util.Map;

import kr.spring.cinema.vo.CinemaVO;
import kr.spring.cinema.vo.TheaterVO;
import kr.spring.movie.vo.MovieTimeVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.seat.vo.SeatVO;

public interface CinemaService {
	 
	//영화관
	public List<CinemaVO> selectCinemaList(Map<String,Object> map);
	public Integer selectCinemaCount(Map<String,Object> map);
	public void insertCinema(CinemaVO cinema);
	public CinemaVO selectCinema(Long c_num);
	public void updateCinema(CinemaVO cinema);
	public void deleteCinema(Long c_num);

 
	//상영관
	public List<TheaterVO> selectTheaterListByCinemaNum(long c_num);
	public Integer selectTheaterCountByCinema(long c_num);

	
	//예매하기 부분 영화 리스트 목록 불러오기
	public List<MovieVO> getMoviesByCinema(long c_num);
	
	
	//영화 시간표 목록 조회
	public List<MovieTimeVO> selectMovieTimeList(long c_num, long m_code, String mt_date);
	
	//좌석 선택 페이지에서 선택한 영화 및 지점명 정보 목록 조회
	public List<MovieTimeVO> selectAllInfoList(long mt_num);
	
	//좌석 목록 조회
	public List<SeatVO> selectSeatList(long mt_num);
	
	
	//새로 만든 예매 페이지 영화목록 조회
	public List<MovieTimeVO> movieReserveList(long c_num);
	
	
	
	
	 /*=======================
     * 영화 시간표
    *=======================*/
	//상영중인 영화만 목록으로 보여주기
	public List<MovieVO> insertTimeMovieList();
	
	//지점명만 목록으로 보여주기
	public List<CinemaVO> insertTimeCinemaList();
	
	//선택한 지점명에 대한 상영관 보여주기
	public List<TheaterVO> insertTimeTheaterList(long c_num);
	
	//상영시간표 등록 시 시간 중복 체크(동일 시간대 상영 유무 확인)
	public boolean checkOverlap(MovieTimeVO movieTimeVO);
	
	
	
		//영화관(잠시 보류)
		//public List<CinemaVO> selectCinemaList(Integer c_location);
		//public Integer selectCinemaRowCount(Map<String,Object> map);
		//public void insertCinema(CinemaVO cinema);
		//public CinemaVO selectCinema(Long c_num);
		//public void updateCinema(CinemaVO cinema);
		//public void deleteCinema(Long c_num);
}
