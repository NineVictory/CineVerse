package kr.spring.admin.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.cinema.service.CinemaService;
import kr.spring.cinema.vo.CinemaVO;
import kr.spring.cinema.vo.TheaterVO;
import kr.spring.movie.service.MovieService;
import kr.spring.movie.vo.MovieActorVO;
import kr.spring.movie.vo.MovieDetailKFAPIVO;
import kr.spring.movie.vo.MovieDirectorVO;
import kr.spring.movie.vo.MovieGenreVO;
import kr.spring.movie.vo.MovieTimeVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.util.FileUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AdminMovieController {
   @Autowired
   private MovieService movieService;
   
   @Autowired
   private CinemaService cinemaService;
     
   /*
    * @Autowired private CinemaService cinemaService;
    */
    
   //자바빈(VO) 초기화
      @ModelAttribute
      public MovieVO initCommand() {
         return new MovieVO();
      }
   //자바빈 초기화
      @ModelAttribute
      public MovieTimeVO initMovieTimeVO() {
          return new MovieTimeVO();
      }
   /*=======================
    * 영화 등록
   *=======================*/
   //등록 폼에서 전송된 데이터 처리
      @PostMapping("/admin/insertMovie")
      public String insertMovie(@Valid MovieVO movieVO, 
                        BindingResult result, 
                        HttpSession session,
                        HttpServletRequest request,
                        Model model) throws IllegalStateException,IOException {
         log.debug("<<영화등록 저장>> : "+movieVO);
         
         /*
          * //유효성 체크 결과 오류가 있으면 폼 호출 if(result.hasErrors()) { return form(); } //오류가 없으면
          * 정보처리를 함.
          */         
         movieVO.setM_filename(FileUtil.createFile(request, movieVO.getM_upload()));
         //영화등록
         
         log.debug("Before inserting movie: {}", movieVO.getM_genre());
         
          movieService.insertMovie(movieVO); 
          
          log.debug("After inserting movie: {}", movieVO.getM_genre());
         
         
         //View 메시지 처리
         model.addAttribute("message","성공적으로 글이 등록되었습니다.");
         model.addAttribute("url",request.getContextPath()+"/admin/adminMovieForm");
         
         
         
         return "common/resultAlert";
      }
		/*
		 * @GetMapping("/admin/adminMovieForm") public String
		 * showMovieForm(@RequestParam(required = false) String title, Model model) { if
		 * (title != null) { MovieDetailKFAPIVO movieDetail =
		 * movieService.selectDetailKFAPIVO(title);
		 * log.debug("Retrieved movie detail: {}", movieDetail); // 로그 추가
		 * model.addAttribute("movieDetail", movieDetail); }
		 * 
		 * model.addAttribute("movieVO", new MovieVO());
		 * 
		 * return "adminMovieForm"; }
		 */
      @GetMapping("/admin/adminMovieForm")
      public String showMovieForm(@RequestParam(required = false) String title, Model model) {
          if (title != null) {
              MovieDetailKFAPIVO movieDetail = movieService.selectDetailKFAPIVO(title);
              if (movieDetail != null) {
                  MovieVO movieVO = new MovieVO();
                  movieVO.setM_name(movieDetail.getTitle());
                  movieVO.setM_opendate(movieDetail.getRepRlsDate());
                  movieVO.setM_companys(movieDetail.getCompany());
                  movieVO.setRuntime(movieDetail.getRuntime());
				  movieVO.setM_filename(movieDetail.getPosters());
                  movieVO.setRating(movieDetail.getRating());
                  movieVO.setM_genre(movieDetail.getGenre());
                  movieVO.setDirector(movieDetail.getDirectorNm());
                  movieVO.setActor(movieDetail.getActorNm());
                  movieVO.setPlot(movieDetail.getPlot());
                  movieVO.setM_content(movieDetail.getTeasers());
                  model.addAttribute("movieVO", movieVO);
              } else {
                  model.addAttribute("movieVO", new MovieVO());
              }
          } else {
              model.addAttribute("movieVO", new MovieVO());
          }
          
          return "adminMovieForm";
      }


      // title로 영화 정보를 가져오는 메서드 (JSON 응답)
      @GetMapping("/admin/getMovieDetail")
      @ResponseBody
      public MovieDetailKFAPIVO getMovieDetail(@RequestParam String title) {
          return movieService.selectDetailKFAPIVO(title);
      }

      /*=======================
       * 영화 시간표
      *=======================*/
      //등록 폼
      @GetMapping("/admin/adminMovieTime")
      public String showInsertMovieTimeForm(Model model) {

          List<MovieVO> movieList = cinemaService.insertTimeMovieList();
          List<CinemaVO> cinemaList = cinemaService.insertTimeCinemaList();
          
          model.addAttribute("movieList", movieList);
          model.addAttribute("cinemaList", cinemaList);
          return "adminMovieTime";
      }
      
      	//상영관 정보를 반환하는 Ajax 메서드
	      @GetMapping("/getTheaters")
	      @ResponseBody
	      public List<TheaterVO> getTheaters(long c_num) {
	          return cinemaService.insertTimeTheaterList(c_num);
	      }
      
      
      //등록 폼에서 전송된 데이터 처리
         @PostMapping("/admin/adminMovieTime")
         public String insertMovieTime(@Valid MovieTimeVO movietimeVO, 
                                       BindingResult result, 
                                       HttpSession session,
                                       HttpServletRequest request,
                                       Model model) throws IllegalStateException,IOException {
            log.debug("<<영화 시간표 저장>> : "+movietimeVO);
               
            
            // 시간대 중복 체크
            if (cinemaService.checkOverlap(movietimeVO)) {
                model.addAttribute("message", "선택한 시간대가 이미 등록된 상영 시간과 겹칩니다.");
                model.addAttribute("url", request.getContextPath() + "/admin/adminMovieTime");
                return "common/resultAlert";
            }
            
            try {
                // 영화 시간표 등록
                movieService.insertMovieTime(movietimeVO);
                log.debug("<<영화 시간표 저장>> : " + movietimeVO);
                
                model.addAttribute("message", "성공적으로 시간이 등록되었습니다.");
                model.addAttribute("url", request.getContextPath() + "/admin/adminMovieTime");
                
                return "common/resultAlert"; // 성공 시 결과 알림 페이지로 이동
            } catch (Exception e) {
                log.error("영화 시간표 저장 중 오류 발생", e);
                model.addAttribute("message", "데이터 저장 중 오류가 발생했습니다.");
                model.addAttribute("url", request.getContextPath() + "/admin/adminMovieTime");
                return "common/resultAlert"; // 오류 발생 시 결과 알림 페이지로 이동
            }
         }
      
      
}
