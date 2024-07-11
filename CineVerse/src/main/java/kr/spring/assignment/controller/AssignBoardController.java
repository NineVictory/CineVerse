package kr.spring.assignment.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.assignment.vo.AssignVO;
import kr.spring.board.vo.BoardVO;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AssignBoardController {

	
	
	//자바빈(VO) 초기화
	@ModelAttribute
	public AssignVO initCommand() {
		return new AssignVO();
	}
	
	
	/*====================
	 *양도게시판 글작성
	 =====================*/
	@GetMapping("/assignboard/write")
	public String form() {
		return "assignWrite";
	}
	
	/*====================
	 *양도게시판 목록
	 =====================*/
	@GetMapping("/assignboard/list")
	public String getList(@RequestParam(defaultValue="1") int pageNum,
						  @RequestParam(defaultValue="2") int order,
						  String keyfield, String keyword, Model model) {
		
		
		return "assignList";
	}
	
	/*====================
	 *양도게시판 글상세
	 =====================*/
	@GetMapping("/assignboard/detail")
	public ModelAndView process() {
		
		
		return new ModelAndView("assignView");
	}
	
	
}
