package kr.spring.assignment.controller;

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
import org.springframework.web.servlet.ModelAndView;

import kr.spring.assignment.service.AssignBoardService;
import kr.spring.assignment.vo.AssignVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AssignController {

	
	@Autowired
	private AssignBoardService assignboardService;
	
	//자바빈(VO) 초기화
	@ModelAttribute
	public AssignVO initCommand() {
		return new AssignVO();
	}
	
	
	/*====================
	 *양도게시판 글쓰기
	 =====================*/
	//등록 폼 호출
	@GetMapping("/assignboard/write")
	public String form() {
		return "assignWrite";
	}
	
	//등록 폼에서 전송된 데이터 처리
	@PostMapping("/assignboard/write")
	public String submit(@Valid AssignVO assignVO, BindingResult result,
						HttpServletRequest request, HttpSession session, Model model)throws IllegalStateException,IOException{
	log.debug("<<양도게시판 글 등록>> : " + assignVO);
	
	//유효성 체크 결과 오류가 있으면 폼 호출
	if(result.hasErrors()) {
		return form();
	}
	
	//회원번호 셋팅
	MemberVO vo = (MemberVO)session.getAttribute("user");
	assignVO.setMem_num(vo.getMem_num());
	//ip 셋팅
	assignVO.setAb_ip(request.getRemoteAddr());
	
	//글쓰기
	assignboardService.a_insertBoard(assignVO);
	
	//View 메시지 처리
	model.addAttribute("message", "성공적으로 글이 등록되었습니다.");
	model.addAttribute("url", request.getContextPath() + "/assignboard/list");
	return "common/resultAlert";
	}
	
	
	/*====================
	 *양도게시판 목록
	 =====================*/
	@GetMapping("/assignboard/list")
	public String getList(@RequestParam(defaultValue="1") int pageNum,
						  @RequestParam(defaultValue="2") int order,
						  @RequestParam(defaultValue="") String ab_type,
						  String keyfield, String keyword, Model model) {
		
		log.debug("<<양도게시판 목록 - ab_type>> : " + ab_type);
		log.debug("<<양도게시판 목록 - order>> : " + order);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("ab_type", ab_type);
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체, 검색 레코드수
		int count = assignboardService.a_selectRowCount(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,pageNum,count,20,10,"list","&ab_type=" + ab_type + "&order="+order);
		List<AssignVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = assignboardService.a_selectList(map);
		}
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
		
		return "assignList";
	}
	/*====================
	 *양도게시판 글상세
	 =====================*/
	@GetMapping("/assignboard/detail")
	public ModelAndView process(long ab_num) {
		log.debug("<<게시판 글 상세 - ab_num>> : " + ab_num);
		
		//해당 글의 조회수 증가
		assignboardService.a_updateHit(ab_num);
		
		AssignVO assign = assignboardService.a_selectBoard(ab_num);
		
		//제목에 태그를 허용하지 않음
		assign.setAb_title(StringUtil.useNoHTML(assign.getAb_title()));
		
		//내용에 태그를 허용하지 않으면서 줄바꿈 처리(CKEditor 사용시 주석 처리)
		//board.setContent(StringUtil.useBrNoHTML(board.getContent()));
		
		return new ModelAndView("assignView", "assign", assign);
	}
	
	/*====================
	 *양도게시판 글수정
	 =====================*/
	//수정 폼 호출
	@GetMapping("/assignboard/update")
	public String formUpdate(long cb_num, Model model) {
		AssignVO assignVO = assignboardService.a_selectBoard(cb_num);
		model.addAttribute("assignVO", assignVO);
		
		return "assignModify";
	}
	//수정 폼에서 전송된 데이터 처리
	@PostMapping("/assignboard/update")
	public String submitUpdate(@Valid AssignVO assignVO, BindingResult result, Model model, HttpServletRequest request) throws IllegalStateException, IOException {
		log.debug("<<양도게시판 글 수정>> : " + assignVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return "assignModify";
		}
		//ip 셋팅
		assignVO.setAb_ip(request.getRemoteAddr());
		//글 수정
		assignboardService.a_updateBoard(assignVO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "글 수정 완료");
		model.addAttribute("url", request.getContextPath() + "/assignboard/detail?ab_num=" + assignVO.getAb_num());
		return "common/resultAlert";
	}
	/*====================
	 *양도게시판 글삭제
	 =====================*/
	@GetMapping("/assignboard/delete")
	public String submitDelete(long ab_num, HttpServletRequest request) {
		log.debug("<<양도게시판 글 삭제 - ab_num>> : " + ab_num);
		
		//글 삭제
		assignboardService.a_deleteBoard(ab_num);
		
		return "redirect:/assignboard/list";
	}
}
