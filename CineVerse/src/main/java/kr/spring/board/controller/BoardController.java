package kr.spring.board.controller;

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

import kr.spring.board.service.BoardService;
import kr.spring.board.vo.BoardVO;
import kr.spring.main.controller.CommonController;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BoardController {

	
	@Autowired
	private BoardService boardService;
	
	//자바빈(VO) 초기화
	@ModelAttribute
	public BoardVO initCommand() {
		return new BoardVO();
	}
	
	/*====================
	 *게시판 글쓰기
	 =====================*/
	//등록 폼 호출
	@GetMapping("/board/write")
	public String form() {
		return "boardWrite";
	}
	
	//등록 폼에서 전송된 데이터 처리
	@PostMapping("/board/write")
	public String submit(@Valid BoardVO boardVO, BindingResult result,
						HttpServletRequest request, HttpSession session, Model model)throws IllegalStateException,IOException{
	log.debug("<<게시판 글 등록>> : " + boardVO);
	
	//유효성 체크 결과 오류가 있으면 폼 호출
	if(result.hasErrors()) {
		return form();
	}
	
	//회원번호 셋팅
	MemberVO vo = (MemberVO)session.getAttribute("user");
	boardVO.setMem_num(vo.getMem_num());
	//ip 셋팅
	boardVO.setCb_ip(request.getRemoteAddr());
	//파일 업로드											multipartfile로 반환
	boardVO.setCb_filename(FileUtil.createFile(request, boardVO.getUpload()));
	
	//글쓰기
	boardService.insertBoard(boardVO);
	
	//View 메시지 처리
	model.addAttribute("message", "성공적으로 글이 등록되었습니다.");
	model.addAttribute("url", request.getContextPath() + "/board/list");
	return "common/resultAlert";
	}
	
	
	/*====================
	 *게시판 목록
	 =====================*/
	@GetMapping("/board/list")
	public String getList(@RequestParam(defaultValue="1") int pageNum,
						  @RequestParam(defaultValue="2") int order,
						  @RequestParam(defaultValue="") String type,
						  String keyfield, String keyword, Model model) {
		
		log.debug("<<게시판 목록 - type>> : " + type);
		log.debug("<<게시판 목록 - order>> : " + order);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("type", type);
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체, 검색 레코드수
		int count = boardService.selectRowCount(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,pageNum,count,20,10,"list","&type="+type + "&order="+order);
		List<BoardVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = boardService.selectList(map);
		}
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
		
		return "boardList";
	}
	
	
}
