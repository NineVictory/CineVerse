package kr.spring.movie.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.board.vo.BoardVO;
import kr.spring.cinema.service.CinemaService;
import kr.spring.cinema.vo.CinemaVO;
import kr.spring.cinema.vo.TheaterVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.movie.service.MovieService;
import kr.spring.movie.vo.MovieTimeVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.seat.vo.SeatVO;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MovieController {
	 
	@Autowired
	private MovieService movieService;
	
	@Autowired
	private CinemaService cinemaService;
		
	/*=======================
	 * 영화 목록
	 *=======================*/
	@GetMapping("/movie/movieList")
	public String movieList(@RequestParam(defaultValue = "1") int pageNum,
	                        @RequestParam(defaultValue = "1") int movieorder,
	                        @RequestParam(defaultValue = "") String status,
	                        @RequestParam(defaultValue = "") String keyfield,
	                        @RequestParam(defaultValue = "") String keyword,
	                        Model model) {

	    Map<String, Object> map = new HashMap<>();
	    map.put("keyfield", keyfield);
	    map.put("keyword", keyword);
	    map.put("status", status);

	    // 디버그 로그 추가
	    log.debug("movieList - movieorder: " + movieorder);

	    int count = movieService.selectMovieRowCount(map);

	    PagingUtil page = new PagingUtil(keyfield, keyword, pageNum, count, 30, 10, "movieList", "&movieorder=" + movieorder);
	    List<MovieVO> movielist = null;
	    if (count > 0) {
	        map.put("movieorder", movieorder);
	        map.put("start", page.getStartRow());
	        map.put("end", page.getEndRow());

	        movielist = movieService.selectMovieList(map);
	    }
	    model.addAttribute("count", count);
	    model.addAttribute("movielist", movielist);
	    model.addAttribute("page", page.getPage());
	    
	    // 장르 목록 추가
	    List<String> genres = movieService.selectDistinctGenres();
	    model.addAttribute("genres", genres);
	    
	    return "movieList";
	}
    @GetMapping("/movie/filterMoviesByGenres")
    @ResponseBody
    public List<MovieVO> filterMoviesByGenres(@RequestParam("genres") String[] genres) {
        return movieService.filterMoviesByGenres(Arrays.asList(genres));
    }
	
	/*=======================
	 * 영화 상세
	 *=======================*/
	@GetMapping("/movie/movieDetail")
    public String movieDetail(@RequestParam int m_code, HttpSession session, Model model) {
        MemberVO user = (MemberVO) session.getAttribute("user");
        long userMemNum = user != null ? user.getMem_num() : -1L; // long 타입으로 변경
        
        MovieVO movie = movieService.selectMovie(m_code);
        boolean canWriteReview = movieService.canWriteReview(userMemNum, m_code); 
        
        List<String> videoUrls = new ArrayList<>();
        if (movie.getM_content() != null && !movie.getM_content().trim().isEmpty()) {
            videoUrls = Arrays.asList(movie.getM_content().split("\\s*,\\s*"));
        }
        
        model.addAttribute("movie", movie);
        model.addAttribute("canWriteReview", canWriteReview);
        model.addAttribute("videoUrls", videoUrls);
        return "movieDetail";
    }
	
	/*=======================
	 * 영화 예매 
	 *=======================*/
	 @GetMapping("/movie/movieReserve")
	    public String movieReserve(@RequestParam(defaultValue = "1") int pageNum,
	                               @RequestParam(defaultValue = "1") int order,
	                               @RequestParam(defaultValue = "1") String c_location,
	                               String keyfield, String keyword, Model model) {
		 	
		 
			log.debug("<<영화관 목록 - c_location>> : " + c_location);
			log.debug("<<영화관 목록 - order>> : " + order);
			
			
	        Map<String, Object> map = new HashMap<>();
	        map.put("c_location", c_location);
	        map.put("keyfield", keyfield);
	        map.put("keyword", keyword);

	        // 전체, 검색 레코드 수
	        int count = cinemaService.selectCinemaCount(map);

	        // 페이지 처리
	        PagingUtil page = new PagingUtil(keyfield, keyword, pageNum, count, 20, 10, "movieReserve", "&c_location=" + c_location + "&order=" + order);
	        List<CinemaVO> list = null;
	        if (count > 0) {
	            map.put("order", order);
	            map.put("start", page.getStartRow());
	            map.put("end", page.getEndRow());

	            list = cinemaService.selectCinemaList(map);
	        }
	        

	        model.addAttribute("count", count);
	        model.addAttribute("list", list);
	        model.addAttribute("page", page.getPage());

	        return "movieReserve";
	    }
	 	
	 	//지점명 선택했을 때 영화목록 불러오기
	 	@GetMapping("/getMoviesByCinema")
	    @ResponseBody
	    public List<MovieVO> getMoviesByCinema(long c_num) {
	        return cinemaService.getMoviesByCinema(c_num);
	    }
	 	 
	 	//상영시간표 불러오기
	 	@GetMapping("/selectMovieTimeList")
	    @ResponseBody

	    public List<MovieTimeVO>selectMovieTimeList(long c_num, long m_code, String mt_date2) throws UnsupportedEncodingException, ParseException {

	 		// URL 디코딩
            String decodedDate = URLDecoder.decode(mt_date2, "UTF-8");

            // 날짜 포맷 설정
            SimpleDateFormat inputFormat = new SimpleDateFormat("yy/MM/dd");
            java.util.Date date = (java.util.Date) inputFormat.parse(decodedDate);

            // 포맷을 적용하여 문자열로 변환
            SimpleDateFormat outputFormat = new SimpleDateFormat("yy/MM/dd");
            String mt_date = outputFormat.format(date);

	        return cinemaService.selectMovieTimeList(c_num, m_code, mt_date);
	    }
	
		/*=======================
		 * 좌석 선택
		 *=======================*/
	 	@GetMapping("/movie/movieSeat")
	 	public String movieSeat(long mt_num, Model model) {
	 	    // 선택한 영화 및 지점명 정보 목록 조회
	 	    List<MovieTimeVO> movieInfoList = cinemaService.selectAllInfoList(mt_num);
	 	    List<SeatVO> seatList = cinemaService.selectSeatList(mt_num);
	 	    
	 	    // Model 객체에 데이터 추가
	 	    model.addAttribute("movieInfoList", movieInfoList);
	 	    model.addAttribute("seatList", seatList);
	 	    
	 	    // 뷰 이름 반환
	 	    return "movieSeat"; 
	 	}
	
	/*=======================
	 * 영화 결제
	 *=======================*/
	@GetMapping("/movie/moviePayment")
	public String moviePayment(){
		return "moviePayment";
	}
	
	/*=======================
	 * 영화 상영시간표
	 *=======================*/
	@GetMapping("/movie/movieTime")
	public String movieTime(){
		return "movieTime";
	}
	 	
	
	/*=======================
	 * 3사 영화관 정보
	 *=======================*/
	@GetMapping("/movie/otherMovieInfo")
	public String otherMovieInfo(){
		return "otherMovieInfo";
	}
	
}

