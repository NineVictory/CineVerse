	package kr.spring.admin.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

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

import kr.spring.cinema.service.CinemaService;
import kr.spring.cinema.vo.CinemaVO;
import kr.spring.movie.service.MovieService;
import kr.spring.movie.vo.MovieActorVO;
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
			
			 movieService.insertMovie(movieVO); 
			 
			
			
			
			//View 메시지 처리
			model.addAttribute("message","성공적으로 글이 등록되었습니다.");
			model.addAttribute("url",request.getContextPath()+"/admin/adminMovieForm");
			
			
			
			return "common/resultAlert";
		}

		/*=======================
		 * 영화 시간표
		*=======================*/
		//등록 폼에서 전송된 데이터 처리
			@PostMapping("/admin/insertMovieTime")
			public String insertMovieTime(@Valid MovieTimeVO movietimeVO, 
													BindingResult result, 
													HttpSession session,
													HttpServletRequest request,
													Model model) throws IllegalStateException,IOException {
				log.debug("<<영화 시간표 저장>> : "+movietimeVO);
					
				
				//영화 시간표 등록
				
				 movieService.insertMovieTime(movietimeVO);

	
				model.addAttribute("message","성공적으로 글이 등록되었습니다.");
				model.addAttribute("url",request.getContextPath()+"/admin/adminMovieTime");
				

				
				return "common/resultAlert";
			}
		
		
}
