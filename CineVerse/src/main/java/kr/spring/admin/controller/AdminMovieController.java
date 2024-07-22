package kr.spring.admin.controller;

import java.io.IOException;
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

import kr.spring.movie.service.MovieService;
import kr.spring.movie.vo.MovieDetailKFAPIVO;
import kr.spring.movie.vo.MovieTimeVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.util.FileUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AdminMovieController {
    @Autowired
    private MovieService movieService;

    // 자바빈(VO) 초기화
    @ModelAttribute
    public MovieVO initCommand() {
        return new MovieVO();
    }

    // 자바빈 초기화
    @ModelAttribute
    public MovieTimeVO initMovieTimeVO() {
        return new MovieTimeVO();
    }

    /*=======================
     * 영화 등록
     *=======================*/
    // 등록 폼에서 전송된 데이터 처리
    @PostMapping("/admin/insertMovie")
    public String insertMovie(@Valid MovieVO movieVO, 
                              BindingResult result, 
                              HttpSession session,
                              HttpServletRequest request,
                              Model model) throws IllegalStateException, IOException {
        log.debug("<<영화등록 저장>> : " + movieVO);

        movieVO.setM_filename(FileUtil.createFile(request, movieVO.getM_upload()));
        // 영화등록
        log.debug("Before inserting movie: {}", movieVO.getM_genre());

        movieService.insertMovie(movieVO); 

        log.debug("After inserting movie: {}", movieVO.getM_genre());

        // View 메시지 처리
        model.addAttribute("message", "성공적으로 글이 등록되었습니다.");
        model.addAttribute("url", request.getContextPath() + "/admin/adminMovieForm");

        return "common/resultAlert";
    }

    // 영화등록
    @GetMapping("/admin/adminMovieForm")
    public String showMovieForm(@RequestParam(required = false) String title, Model model) {
        if (title != null) {
            MovieDetailKFAPIVO movieDetail = movieService.selectDetailKFAPIVOByTitle(title);
            model.addAttribute("movieDetail", movieDetail);
        }

        // movieVO 객체를 모델에 추가
        model.addAttribute("movieVO", new MovieVO());
        
        return "adminMovieForm";
    }

    // title로 영화 정보를 가져오는 메서드 (JSON 응답)
    @GetMapping("/admin/getMovieDetail")
    @ResponseBody
    public MovieDetailKFAPIVO getMovieDetail(@RequestParam String title) {
        return movieService.selectDetailKFAPIVOByTitle(title);
    }

    /*=======================
     * 영화 시간표
     *=======================*/
    // 등록 폼에서 전송된 데이터 처리
    @PostMapping("/admin/insertMovieTime")
    public String insertMovieTime(@Valid MovieTimeVO movietimeVO, 
                                  BindingResult result, 
                                  HttpSession session,
                                  HttpServletRequest request,
                                  Model model) throws IllegalStateException, IOException {
        log.debug("<<영화 시간표 저장>> : " + movietimeVO);

        // 영화 시간표 등록
        movieService.insertMovieTime(movietimeVO);

        model.addAttribute("message", "성공적으로 글이 등록되었습니다.");
        model.addAttribute("url", request.getContextPath() + "/admin/adminMovieTime");

        return "common/resultAlert";
    }
}
