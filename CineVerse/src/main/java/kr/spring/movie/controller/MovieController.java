package kr.spring.movie.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.spring.cinema.service.CinemaService;
import kr.spring.cinema.vo.CinemaVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.movie.service.MovieService;
import kr.spring.movie.vo.MbDetailVO;
import kr.spring.movie.vo.MovieBookingVO;
import kr.spring.movie.vo.MovieTimeVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.myPage.service.MyPageService;
import kr.spring.myPage.vo.MyPageVO;
import kr.spring.seat.vo.SeatVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MovieController {
    
   @Autowired
   private MovieService movieService;
   
   @Autowired
   private CinemaService cinemaService;
   
   @Autowired
   private MyPageService mypageService;
   
   @Autowired
   private MemberService memberService;
      
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

       PagingUtil page = new PagingUtil(keyfield, keyword, pageNum, count, 1000, 10, "movieList", "&movieorder=" + movieorder);
       List<MovieVO> movielist = null;
       if (count > 0) {
           map.put("movieorder", movieorder);
           map.put("start", page.getStartRow());
           map.put("end", page.getEndRow());

           movielist = movieService.selectMovieList(map);
           for (MovieVO movie : movielist) {
               movie.setM_opendate(formatDate(movie.getM_opendate()));
           }
       }
		List<MovieVO> movieRank = cinemaService.getMovieRankMain();
		model.addAttribute("movieRank",movieRank);
       model.addAttribute("count", count);
       model.addAttribute("movielist", movielist);
       model.addAttribute("page", page.getPage());
       
       // 장르 목록 추가
       List<String> genres = movieService.selectDistinctGenres();
       model.addAttribute("genres", genres);
       
       return "movieList";
   }
   
   /*=======================
    * 현재 상영중인 영화 목록
    *=======================*/
   @GetMapping("/movie/movieListCurrent")
   public String movieListCurrent(@RequestParam(defaultValue = "1") int pageNum,
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
       log.debug("movieListCurrent - movieorder: " + movieorder);

       int count = movieService.selectMovieRowCount(map);

       PagingUtil page = new PagingUtil(keyfield, keyword, pageNum, count, 1000, 10, "movieListCurrent", "&movieorder=" + movieorder);
       List<MovieVO> movieListCurrent = null;
       if (count > 0) {
           map.put("movieorder", movieorder);
           map.put("start", page.getStartRow());
           map.put("end", page.getEndRow());

           movieListCurrent = movieService.selectMovieListCurrent(map);
           for (MovieVO movie : movieListCurrent) {
               movie.setM_opendate(formatDate(movie.getM_opendate()));
           }
       }
       model.addAttribute("count", count);
       model.addAttribute("movieListCurrent", movieListCurrent);
       model.addAttribute("page", page.getPage());
       
       List<MovieVO> movieRank = cinemaService.getMovieRankMain();
		model.addAttribute("movieRank",movieRank);
       
       // 장르 목록 추가
       List<String> genres = movieService.selectDistinctGenres();
       model.addAttribute("genres", genres);
       
       return "movieListCurrent";
   }
   
   /*=======================
    * 상영 예정 영화 목록
    *=======================*/
   @GetMapping("/movie/movieListSchedule")
   public String movieListSchedule(@RequestParam(defaultValue = "1") int pageNum,
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
       log.debug("movieListSchedule - movieorder: " + movieorder);

       int count = movieService.selectMovieRowCount(map);

       PagingUtil page = new PagingUtil(keyfield, keyword, pageNum, count, 1000, 10, "movieListSchedule", "&movieorder=" + movieorder);
       List<MovieVO> movieListSchedule = null;
       if (count > 0) {
           map.put("movieorder", movieorder);
           map.put("start", page.getStartRow());
           map.put("end", page.getEndRow());

           movieListSchedule = movieService.selectMovieListSchedule(map);
           for (MovieVO movie : movieListSchedule) {
               movie.setM_opendate(formatDate(movie.getM_opendate()));
           }
       }
       model.addAttribute("count", count);
       model.addAttribute("movieListSchedule", movieListSchedule);
       model.addAttribute("page", page.getPage());
       
       List<MovieVO> movieRank = cinemaService.getMovieRankMain();
		model.addAttribute("movieRank",movieRank);
       
       // 장르 목록 추가
       List<String> genres = movieService.selectDistinctGenres();
       model.addAttribute("genres", genres);
       
       return "movieListSchedule";
   }
   
    @GetMapping("/movie/filterMoviesByGenres")
    @ResponseBody
    public List<MovieVO> filterMoviesByGenres(@RequestParam("genres") String[] genres) {
        return movieService.filterMoviesByGenres(Arrays.asList(genres));
    }
    
    @GetMapping("/movie/filterMoviesByGenres2")
    @ResponseBody
    public List<MovieVO> filterMoviesByGenres2(@RequestParam("genres") String[] genres) {
        return movieService.filterMoviesByGenres2(Arrays.asList(genres));
    }
    
    @GetMapping("/movie/filterMoviesByGenres3")
    @ResponseBody
    public List<MovieVO> filterMoviesByGenres3(@RequestParam("genres") String[] genres) {
        return movieService.filterMoviesByGenres3(Arrays.asList(genres));
    }
    
    @GetMapping("/movie/allMovies")
    @ResponseBody
    public List<MovieVO> allMovies() {
        Map<String, Object> map = new HashMap<>();
        // 모든 영화를 가져오기 위해 별도의 조건 없이 호출
        return movieService.selectMovieList(map);
    }
   
   /*=======================
    * 영화 상세
    *=======================*/
   @GetMapping("/movie/movieDetail")
    public String movieDetail(@RequestParam Long m_code, HttpSession session, Model model) {
        MemberVO user = (MemberVO) session.getAttribute("user");
        long userMemNum = user != null ? user.getMem_num() : -1L; // long 타입으로 변경
        
        MovieVO movie = movieService.selectMovieDetail(m_code);
        movie.setM_opendate(formatDate(movie.getM_opendate()));
        boolean canWriteReview = movieService.canWriteReview(userMemNum, m_code); 
        
		/*
		 * List<String> teasers = new ArrayList<>(); if (movie.getM_content() != null &&
		 * !movie.getM_content().trim().isEmpty()) { teasers =
		 * Arrays.asList(movie.getM_content().split("\\s*,\\s*")); }
		 */
        
        model.addAttribute("movie", movie);
        model.addAttribute("canWriteReview", canWriteReview);
		/* model.addAttribute("teasers", teasers); */
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
            Date date = (Date) inputFormat.parse(decodedDate);

            // 포맷을 적용하여 문자열로 변환
            SimpleDateFormat outputFormat = new SimpleDateFormat("yy/MM/dd");
            String mt_date = outputFormat.format(date);
            
            List<MovieTimeVO> list = cinemaService.selectMovieTimeList(c_num, m_code, mt_date);
            
            // 각 영화 시간표에 대해 좌석 수 계산 및 추가
            for (MovieTimeVO movieTime : list) {
                long mt_num = movieTime.getMt_num();
                Integer availableSeats = cinemaService.getAvailableSeats(mt_num);
                movieTime.setAvailableSeats(availableSeats);
            }
            
           return list;
       }
   
       /*=======================
        * 좌석 선택
        *=======================*/
        @GetMapping("/movie/movieSeat")
        public String movieSeat(long mt_num, Model model) {
            // 선택한 영화 및 지점명 정보 목록 조회
            List<MovieTimeVO> movieInfoList = cinemaService.selectAllInfoList(mt_num);
            List<SeatVO> seatList = cinemaService.selectSeatList(mt_num);
            List<SeatVO> bookedSeats = movieService.seatBooking(mt_num);
            
            // 남은 좌석 수 계산
            Integer availableSeats = cinemaService.getAvailableSeats(mt_num);
            
            
            // Model 객체에 데이터 추가
            model.addAttribute("movieInfoList", movieInfoList);
            model.addAttribute("seatList", seatList);
            model.addAttribute("bookedSeats", bookedSeats);
            model.addAttribute("availableSeats", availableSeats);
            // 뷰 이름 반환
            return "movieSeat"; 
        }
   
         /*=======================
        * 영화 결제 
        *=======================*/
           @PostMapping("/movie/moviePayment")
           public String moviePayment(long mt_num, String seatNum, int ticketNumber, String selectedSeats, 
        		   						int payMoney, int adultCount, int youthCount, int seniorCount ,HttpSession session, Model model) {
              log.debug("<<영화 결제 - mt_num>> ::: " + mt_num);
              log.debug("<<영화 결제 - ticketNumber>> ::: " + ticketNumber);
              log.debug("<<영화 결제 - selectedSeats>> ::: " + selectedSeats);
              log.debug("<<영화 결제 - payMoney>> ::: " + payMoney);
               // 영화 정보 조회
               List<MovieTimeVO> movieInfoList = cinemaService.selectAllInfoList(mt_num);
               MemberVO user = (MemberVO)session.getAttribute("user");
               if (user == null) {
                   // 로그인이 되어 있지 않으면 로그인 페이지로 리디렉션
                   return "redirect:/member/login";
               }

             // 보유 쿠폰 정보
             Map<String,Object> map = new HashMap<String,Object>();
             List<MyPageVO> couponList = null;
             map.put("mem_num", user.getMem_num());
             MyPageVO member = mypageService.selectMember(user.getMem_num());
             member.setCoupon_cnt(mypageService.selectMemberCoupon(user.getMem_num()));//복붙
             if(member.getCoupon_cnt() > 0) {
                couponList = mypageService.selectMemCouponList(map);
             }
               // 모델에 데이터를 추가하여 결제 페이지로 넘기기
               model.addAttribute("movieInfoList", movieInfoList);
               model.addAttribute("seatNum", seatNum);
               model.addAttribute("ticketNumber", ticketNumber);
               model.addAttribute("selectedSeats", selectedSeats);  // 좌석 식별자 리스트를 넘김
               model.addAttribute("payMoney", payMoney);
               model.addAttribute("couponList",couponList);
               model.addAttribute("member",member);
               model.addAttribute("adultCount", adultCount);
               model.addAttribute("youthCount", youthCount);
               model.addAttribute("seniorCount", seniorCount);
             
               return "moviePayment"; // 결제 페이지로 이동
           }

           @PostMapping("/movie/confirmPayment")
           public String confirmPayment(RedirectAttributes redirectAttributes,
        		   						@RequestParam("mt_num") long mt_num, 
                                        @RequestParam("ticketNumber") int ticketNumber, 
                                        @RequestParam("selectedSeats") String selectedSeats, 
                                        @RequestParam("finalAmount") long finalAmount,
                                        @RequestParam("seatNum") String seatNum, 
                                        @RequestParam("m_code") long m_code,
                                        @RequestParam(value = "mc_num", required = false) Long mc_num, // 쿠폰 번호 (옵션)
                                        HttpSession session, 
                                        Model model) {
               MemberVO user = (MemberVO) session.getAttribute("user");
               if (user == null) {
                   // 로그인이 되어 있지 않으면 로그인 페이지로 리디렉션
                   return "redirect:/member/login";
               }
               
               log.debug("<<confirmPayment - mt_num>> ::: " + mt_num);
               log.debug("<<confirmPayment - ticketNumber>> ::: " + ticketNumber);
               log.debug("<<confirmPayment - selectedSeats>> ::: " + selectedSeats);
               log.debug("<<confirmPayment - finalAmount>> ::: " + finalAmount);
               log.debug("<<confirmPayment - m_code>> ::: " + m_code);
               log.debug("<<confirmPayment - seatNum>> ::: " + seatNum);
               
               
            // 좌석 번호 배열로 변환
			/*
			 * String[] seatsArray = seatNum.split(","); List<Long> seatNums =
			 * Arrays.stream(seatsArray).map(Long::parseLong).collect(Collectors.toList());
			 */


               
               // 예매 정보 생성
               Long mbNum = movieService.getMbNum(); // mb_num을 미리 가져옴
               MovieBookingVO movieBooking = new MovieBookingVO();
               movieBooking.setMb_num(mbNum); // 미리 가져온 mb_num 설정
               movieBooking.setMb_price(finalAmount);
               movieBooking.setMem_num(user.getMem_num());
               movieBooking.setMt_num(mt_num);
               movieBooking.setM_code(m_code);
               
               // 중복 체크
               int duplicateCount = movieService.checkDuplicateBooking(user.getMem_num(), mt_num, seatNum);
               if (duplicateCount > 0) {
					/* session.setAttribute("errorMessage", "이미 예매된 좌석입니다. 다른 좌석을 선택해주세요."); */
            	    return "redirect:/movie/movieSeat?mt_num="+mt_num;
            	} else {


                    // 서비스 호출하여 예매 처리
                    movieService.insertBooking(movieBooking);
                    
                    // 주문번호(사용자에게 보여줄 용도. PK 아님) 생성
     	            LocalDate today = LocalDate.now();
     	            int year = today.getYear();
     	            int month = today.getMonthValue();
     	            int day = today.getDayOfMonth();
     	            String od_number;
     	            if (month < 10) {
     	                od_number = year + ("-0" + month) + day;
     	            } else {
     	                od_number = year + ("-" + month) + day;
     	            }

     	            Random random = new Random();
     	            String ran_num_result = "-";
     	            for (int i = 0; i < 4; i++) {
     	                int ran_num = random.nextInt(10);
     	                ran_num_result += ran_num;
     	            }

     	            
     	            // 주문 번호 (간지용) 설정
     	            od_number = od_number + ran_num_result + "-" + movieBooking.getMb_num();

     	            movieService.updateUserMbNum(movieBooking.getMb_num(), od_number);
                    
                    log.debug("<<movieBooking - movieBooking>> ::: " + movieBooking);

                    String[] seats = seatNum.split(",");
                    
                    
                    for (String seat : seats) {
                        MbDetailVO mbDetail = new MbDetailVO();
                        mbDetail.setMd_type(1); // 예시로 사용, 실제로는 필요한 값 설정
                        mbDetail.setMb_num(mbNum);
                        mbDetail.setSeat_num(Long.parseLong(seat.trim())); // seat_num을 long으로 변환하여 설정
                        movieService.insertBookingDetail(mbDetail);
                    }

                    // 포인트 차감 및 기록
     				/* movieService.updateMemberPoint(remainingPoints, user.getMem_num()); */
                   
                    movieService.insertPointHistory(finalAmount, user.getMem_num(), 1, "영화 예약");

                    // 쿠폰 사용 상태 업데이트
                    if (mc_num != null) {
                        movieService.useCoupon(movieBooking.getMb_num(), mc_num);
                    }

                    memberService.totalPoint(user.getMem_num());
                    // 결제 완료 후 완료 페이지로 이동
                    return "redirect:/myPage/reservationList";
            	}
               
               
           }





   
           /*=======================
            * 영화 상영시간표
            *=======================*/
           @GetMapping("/movie/movieTime")
           public String movieTime(Model model){
        	   
        	  List<MovieVO> movieList = cinemaService.showMovieList();
        	  model.addAttribute("movieList", movieList);
              return "movieTime";
           }
               
           //영화에 맞는 시간표 불러오기
           @GetMapping("/showMovieTimeList")
           @ResponseBody

           public List<MovieTimeVO>showMovieTimeList(long m_code, String mt_date2, String c_location) throws UnsupportedEncodingException, ParseException {

              // URL 디코딩
                String decodedDate = URLDecoder.decode(mt_date2, "UTF-8");
                String decodedDate2 = URLDecoder.decode(c_location, "UTF-8");
                
                // 날짜 포맷 설정
                SimpleDateFormat inputFormat = new SimpleDateFormat("yy/MM/dd");
                Date date = (Date) inputFormat.parse(decodedDate);

                // 포맷을 적용하여 문자열로 변환
                SimpleDateFormat outputFormat = new SimpleDateFormat("yy/MM/dd");
                String mt_date = outputFormat.format(date);
                
                List<MovieTimeVO> list = cinemaService.showMovieTimeList(m_code, mt_date, decodedDate2);
                
                // 각 영화 시간표에 대해 좌석 수 계산 및 추가
                for (MovieTimeVO movieTime : list) {
                    	long mt_num = movieTime.getMt_num();
                    	Integer availableSeats = cinemaService.getAvailableSeats(mt_num);
                    	movieTime.setAvailableSeats(availableSeats);
                	}
                
               return list;
           }
       
   
   /*=======================
    * 3사 영화관 정보
    *=======================*/
   @GetMapping("/movie/otherMovieInfo")
   public String otherMovieInfo(){
      return "otherMovieInfo";
   }
   
   private String formatDate(String date) {
	    try {
	        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyyMMdd");
	        SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
	        Date parsedDate = inputFormat.parse(date);
	        return outputFormat.format(parsedDate);
	    } catch (ParseException e) {
	        e.printStackTrace();
	        return date; // 변환 실패 시 원본 반환
	    }
	}
   
}