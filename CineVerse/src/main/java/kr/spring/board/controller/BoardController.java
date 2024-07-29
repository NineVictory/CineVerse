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
import org.springframework.web.servlet.ModelAndView;

import kr.spring.assignment.vo.AssignReportVO;
import kr.spring.board.service.BoardService;
import kr.spring.board.vo.BoardReportVO;
import kr.spring.board.vo.BoardVO;
import kr.spring.board.vo.CommentReportVO;
import kr.spring.board.vo.ResponseReportVO;
import kr.spring.main.controller.CommonController;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
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
	//자바빈(VO) 초기화
	@ModelAttribute
	public BoardReportVO initCommand2() {
		return new BoardReportVO();
	}
	//자바빈(VO) 초기화
	@ModelAttribute
	public CommentReportVO initCommand3() {
		return new CommentReportVO();
	}
	//자바빈(VO) 초기화
	@ModelAttribute
	public ResponseReportVO initCommand4() {
		return new ResponseReportVO();
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
						  @RequestParam(defaultValue="1") int order,
						  @RequestParam(defaultValue="") String cb_type,
						  String keyfield, String keyword, Model model) {
		
		log.debug("<<게시판 목록 - cb_type>> : " + cb_type);
		log.debug("<<게시판 목록 - order>> : " + order);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("cb_type", cb_type);
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체, 검색 레코드수
		int count = boardService.selectRowCount(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,pageNum,count,10,10,"list","&cb_type="+cb_type + "&order="+order);
		List<BoardVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = boardService.selectList(map);
			
			for(BoardVO boardVO : list) {
				boardVO.setAll_comments(boardService.selectResponseCountByCbNum(boardVO.getCb_num())
						+boardService.selectRowCountComment(boardVO.getCb_num()));
			}
		}
		
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
		
		return "boardList";
	}
	
	/*====================
	 *게시판 글상세
	 =====================*/
	@GetMapping("/board/detail")
	public String process(long cb_num, Model model, HttpServletRequest request) {
		log.debug("<<게시판 글 상세 - cb_num>> : " + cb_num);
		
		
		
		BoardVO board = boardService.selectBoard(cb_num);
		
		if(board.getCc_report() >= 5) {
			model.addAttribute("message", "신고 정지된 글입니다.");
			model.addAttribute("url", request.getContextPath() + "/board/list");
			return "common/resultAlert";
		}
		//해당 글의 조회수 증가
		boardService.updateHit(cb_num);
		
		long all_resp = boardService.selectResponseCountByCbNum(cb_num);
		long re_cnt = boardService.selectRowCountComment(cb_num);
		
		long all_comments = all_resp + re_cnt;
		
		//제목에 태그를 허용하지 않음
		board.setCb_title(StringUtil.useNoHTML(board.getCb_title()));
		
		//내용에 태그를 허용하지 않으면서 줄바꿈 처리(CKEditor 사용시 주석 처리)
		//board.setContent(StringUtil.useBrNoHTML(board.getContent()));
		
		model.addAttribute("board", board);
		model.addAttribute("comment_cnt", all_comments);
		//ModelAndView modelAndView = new ModelAndView("boardView");
		//modelAndView.addObject("board", board);
		//modelAndView.addObject("comment_cnt", all_comments);
		return "boardView";
	}
	
	
	/*====================
	 *커뮤니티 신고
	 =====================*/
	
	//커뮤니티 신고폼
	@GetMapping("/board/boardReportForm")
	public String reportForm() {
		
		return "boardReportForm";
	}
	
	//신고폼 데이터 처리
	@PostMapping("/board/submitBoardReport")
	public String submitReport(BoardReportVO boardReport, BindingResult result, Model model) {
		if(result.hasErrors()) {
			return "boardReportForm";
		}
		
		boardService.boardReport(boardReport);
		model.addAttribute("message","신고가 접수되었습니다.");
		return "/common/resultAlert2";
	}
	
	
	
	/*====================
	 *게시판 글수정
	 =====================*/
	//수정 폼 호출
	@GetMapping("/board/update")
	public String formUpdate(long cb_num, Model model) {
		BoardVO boardVO = boardService.selectBoard(cb_num);
		model.addAttribute("boardVO", boardVO);
		
		return "boardModify";
	}
	//수정 폼에서 전송된 데이터 처리
	@PostMapping("/board/update")
	public String submitUpdate(@Valid BoardVO boardVO, BindingResult result, Model model, HttpServletRequest request) throws IllegalStateException, IOException {
		log.debug("<<게시판 글 수정>> : " + boardVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			
			return "boardModify";
		}
		//ip 셋팅
		boardVO.setCb_ip(request.getRemoteAddr());
		//글 수정
		boardService.updateBoard(boardVO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "글 수정 완료");
		model.addAttribute("url", request.getContextPath() + "/board/detail?cb_num=" + boardVO.getCb_num());
		return "common/resultAlert";
	}
	
	/*====================
	 *게시판 글삭제
	 =====================*/
	@GetMapping("/board/delete")
	public String submitDelete(long cb_num, HttpServletRequest request) {
		log.debug("<<게시판 글 삭제 - cb_num>> : " + cb_num);
		
		//글 삭제
		boardService.deleteBoard(cb_num);
		
		return "redirect:/board/list";
	}
	
	
	
	/*====================
	 *댓글 신고
	 =====================*/
	//댓글 신고폼
	@GetMapping("/board/commentReportForm")
	public String commentReportForm() {
		
		return "commentReportForm";
	}
	
	//신고폼 데이터 처리
	@PostMapping("/board/submitCommentReport")
	public String submitCommentReport(CommentReportVO commentReport, BindingResult result, Model model) {
		if(result.hasErrors()) {
			return "commentReportForm";
		}
		
		boardService.commentReport(commentReport);
		model.addAttribute("message","신고가 접수되었습니다.");
		return "/common/resultAlert2";
	}
	
	/*====================
	 *답글 신고
	 =====================*/
	//답글 신고폼
	@GetMapping("/board/responseReportForm")
	public String responseReportForm() {
		
		return "responseReportForm";
	}
	
	//신고폼 데이터 처리
	@PostMapping("/board/submitResponseReport")
	public String submitResponseReport(ResponseReportVO responseReport, BindingResult result, Model model) {
		if(result.hasErrors()) {
			return "responseReportForm";
		}
		
		boardService.responseReport(responseReport);
		model.addAttribute("message","신고가 접수되었습니다.");
		return "/common/resultAlert2";
	}
}
