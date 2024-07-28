package kr.spring.movie.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.movie.vo.MovieBookMarkVO;
import kr.spring.movie.vo.MovieReviewfavVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.movie.service.MovieService;
import kr.spring.movie.vo.MovieBookingVO;
import kr.spring.movie.vo.MovieReviewReportReporterVO;
import kr.spring.movie.vo.MovieReviewReportVO;
import kr.spring.movie.vo.MovieReviewVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MovieAjaxController {

    @Autowired
    private MovieService movieService;
    /*===================
	부모글 북마크 읽기
	===================*/
    // 영화 북마크 읽기
    @GetMapping("/movie/getbookMark")
    @ResponseBody
    public Map<String, Object> getbookMark(MovieBookMarkVO bookMark, HttpSession session) {
        log.debug("<<영화디테일 북마크 - MovieBookMarkVO>> : " + bookMark);

        Map<String, Object> mapJson = new HashMap<String, Object>();

        MemberVO user = (MemberVO) session.getAttribute("user");
        if (user == null) {
            mapJson.put("status", "nobookMark");
        } else {
            // 로그인된 회원번호 셋팅
            bookMark.setMem_num(user.getMem_num());
            MovieBookMarkVO moviebookMark = movieService.selectBookMark(bookMark);
            if (moviebookMark != null) {
                mapJson.put("status", "yesbookMark");
            } else {
                mapJson.put("status", "nobookMark");
            }
        }
        mapJson.put("count", movieService.selectBookMarkCount(bookMark.getM_code()));

        return mapJson;
    }

    // 영화 북마크 등록/삭제
    @PostMapping("/movie/writebookMark")
    @ResponseBody
    public Map<String, Object> writebookMark(MovieBookMarkVO bookMark, HttpSession session) {
        log.debug("<<영화디테일 북마크 -등록 >>:" + bookMark);

        Map<String, Object> mapJson = new HashMap<String, Object>();

        MemberVO user = (MemberVO) session.getAttribute("user");
        if (user == null) {
            mapJson.put("result", "logout");
        } else {
            // 로그인된 회원번호 세팅
            bookMark.setMem_num(user.getMem_num());

            MovieBookMarkVO moviebookMark = movieService.selectBookMark(bookMark);
            if (moviebookMark != null) {
                // 등록 -> 삭제
                movieService.deleteBookMark(bookMark);
                mapJson.put("status", "nobookMark");
            } else {
                // 등록
                movieService.insertBookMark(bookMark);
                mapJson.put("status", "yesbookMark");
            }
            mapJson.put("result", "success");
            mapJson.put("count", movieService.selectBookMarkCount(bookMark.getM_code()));
        }

        return mapJson;
    }
    /*=======================
	 * 리뷰 등록
	 *=======================*/
    @PostMapping("/movie/writeReview")
    @ResponseBody
    public Map<String,String> writeReview(@ModelAttribute MovieReviewVO review, HttpSession session) {
        MemberVO user = (MemberVO) session.getAttribute("user");
        long userMemNum = user != null ? user.getMem_num() : -1L;
        Map<String,String> mapJson = new HashMap<String, String>();
		/*
		 * // mb_num이 없는 경우에 대한 기본값 설정 if (review.getMb_num() == 0) { return "fail"; //
		 * 적절한 처리로 변경 가능 }
		 */
        
        boolean canWriteReview = movieService.canWriteReview(userMemNum, review.getM_code());
        if(user == null) {
			//로그인 안된경우
			mapJson.put("result","logout");
		}
        else if(canWriteReview) {
            review.setMem_num(userMemNum);
         // mb_num 값 설정
            MovieBookingVO bookingInfo = movieService.getBookingInfo(userMemNum, review.getM_code());
            if (bookingInfo != null) {
                review.setMb_num(bookingInfo.getMb_num());
            }
            log.debug("리뷰 등록: " + review);
            movieService.insertReview(review);
            mapJson.put("result","success");
        } 
        return mapJson;
    }
    /*===================
	리뷰 목록
===================*/
    @GetMapping("/movie/listReview")
    @ResponseBody
    public Map<String, Object> getList(Long m_code, int pageNum, int rowCount, String order, HttpSession session) {
        log.debug("<<리뷰 목록 - m_code>> : " + m_code);
        log.debug("<<리뷰 목록 - page_num>> : " + pageNum);
        log.debug("<<리뷰 목록 - rowCount>> : " + rowCount);
        log.debug("<<리뷰 목록 - order>> : " + order);
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("m_code", m_code);
        map.put("order", order); // 추가된 부분



        MemberVO user = (MemberVO) session.getAttribute("user");
        if (user != null) {
            map.put("mem_num", user.getMem_num());
        } else {
            map.put("mem_num", 0);
        }
        
        // 총글의 개수
        int count = movieService.selectMovieRowCountReview(map);

        // 페이지 처리
        PagingUtil page = new PagingUtil(pageNum, count, rowCount);
        map.put("start", page.getStartRow());
        map.put("end", page.getEndRow());
        
        List<Long> hiddenReviewIds = movieService.getHiddenReviewIds();
        List<MovieReviewVO> list = null;

        if (count > 0) {
			list = movieService.selectMovieListReview(map);
			
	     	list.removeIf(review -> hiddenReviewIds.contains(review.getMr_num()));
        } else {
            list = Collections.emptyList();
        }

        Map<String, Object> mapJson = new HashMap<String, Object>();
        mapJson.put("count", count);
        mapJson.put("list", list);
        if (user != null) {
            mapJson.put("user_num", user.getMem_num());
        }

        return mapJson;
    }
	/*===================
	리뷰 삭제
	===================*/
	@PostMapping("/movie/deleteReview")
	@ResponseBody
	public Map<String,String> deleteReply(long mr_num,
											HttpSession session){
		log.debug("<<리뷰 삭제 - re_num>>:"+ mr_num);
		
		Map<String,String> mapJson = new HashMap<String, String>();
		MemberVO user = (MemberVO)session.getAttribute("user"); //로그인을 했는지 확인하기위해 (회원제 서비스이기 떄문에)
		MovieReviewVO db_reply = movieService.selectReview(mr_num);
		
		if(user == null) {
			//로그인이 되지 않은 경우
			mapJson.put("result","logout");
		}else if(user !=null 
				&& user.getMem_num()==db_reply.getMem_num()) {
			//로그인 회원번호와 작성자 회원번호 일치	
	        movieService.deleteReview(mr_num);
			mapJson.put("result","success");
		}else {
			//로그인 회원번호와 작성자 회원번호 불일치
			mapJson.put("result","wrongAccess");
		}
		
		return mapJson;
	}
	/*===================
	리뷰 좋아요 읽기
	===================*/
	@GetMapping("/movie/getReFav")
	@ResponseBody
	public Map<String,Object> getReFav(
								MovieReviewfavVO fav,
								HttpSession session){
		log.debug("<<리뷰 좋아요>>:" +fav);
		
		Map<String,Object> mapJson = new HashMap<String, Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user"); //로그인을 했는지 확인하기위해 (회원제 서비스이기 떄문에)
		if(user == null) {
			mapJson.put("result","success");
			mapJson.put("result","noFav");
		}else {
			fav.setMem_num(user.getMem_num());
			MovieReviewfavVO boardReFav = movieService.selecReFav(fav);
			if(boardReFav!=null) {
				mapJson.put("result","success");
				mapJson.put("result","yesFav");
			}else {
				mapJson.put("result","success");
				mapJson.put("result","noFav");
			}
		}
		mapJson.put("count",movieService.selectReFavCount(fav.getMr_num()));
		return mapJson;
	}
	/*===================
	리뷰 좋아요 등록/삭제
	===================*/
	@PostMapping("/movie/writeReFav")
	@ResponseBody
	public Map<String,Object>writeReFav(
	                            MovieReviewfavVO fav,
	                            HttpSession session){
	    log.debug("<<리뷰 좋아요 등록/삭제>>:" +fav);

	    Map<String,Object> mapJson = new HashMap<String, Object>();

	    MemberVO user = (MemberVO)session.getAttribute("user"); //로그인을 했는지 확인하기위해 (회원제 서비스이기 떄문에)
	    if(user == null) {
	        mapJson.put("result","logout");
	    }else {
	        fav.setMem_num(user.getMem_num());
	        MovieReviewfavVO movieReFav = movieService.selecReFav(fav);
	        if(movieReFav!=null) {
	            log.debug("좋아요 삭제");
	            movieService.deleteReFav(fav);
	            mapJson.put("status","noFav");
	        }else {
	            log.debug("좋아요 추가");
	            movieService.insertReFav(fav);
	            mapJson.put("status","yesFav");
	        }
	        mapJson.put("result","success");
	        mapJson.put("count",movieService.selectReFavCount(fav.getMr_num()));
	    }

	    return mapJson;
	}
    @GetMapping("/movie/loadMoreMovies")
    @ResponseBody
    public Map<String, Object> loadMoreMovies(@RequestParam(defaultValue = "1") int pageNum,
                                              @RequestParam(defaultValue = "8") int rowCount,
                                              @RequestParam(defaultValue = "1") int movieorder,
                                              String keyfield, String keyword) {

        Map<String, Object> map = new HashMap<>();
        map.put("keyfield", keyfield);
        map.put("keyword", keyword);

        int count = movieService.selectMovieRowCount(map);

        PagingUtil page = new PagingUtil(keyfield, keyword, pageNum, count, rowCount, 10, "movieList", "&movieorder=" + movieorder);
        map.put("movieorder", movieorder);
        map.put("start", page.getStartRow());
        map.put("end", page.getEndRow());

        List<MovieVO> movielist = movieService.selectMovieList(map);
        Map<String, Object> result = new HashMap<>();
        result.put("movielist", movielist);
        result.put("count", count);

        return result;
    }
    
    /*=======================
	 * 리뷰 신고 처리
	 *=======================*/
    
    
    
    @PostMapping("/movie/reportReview")
    @ResponseBody
    public Map<String, String> reportReview(MovieReviewReportVO report, @RequestParam long mr_num,@RequestParam String rr_type,HttpSession session) {
        Map<String, String> mapJson = new HashMap<>();
        
        MemberVO user = (MemberVO) session.getAttribute("user");
        
        if (user == null) {
            mapJson.put("result", "logout");
            return mapJson;
        }
        long mem_num = user.getMem_num();
        
        // 중복 신고 여부 확인   
        Integer isDuplicate = movieService.checkDuplicateReport(mr_num, mem_num);
        if (isDuplicate > 0) {
            mapJson.put("result", "duplicate");
            return mapJson;
        }

            // 리뷰 신고 등록
            report.setMr_num(mr_num);
            report.setRr_type(rr_type);

		    movieService.insertReviewReport(report);
            
            // 신고자 정보 등록
            MovieReviewReportReporterVO reporter = new MovieReviewReportReporterVO();
            reporter.setRr_num(report.getRr_num());
            reporter.setMem_num(mem_num);
            movieService.insertReviewReporter(reporter);
            
            
            mapJson.put("result", "success");

        return mapJson;
    }
}
