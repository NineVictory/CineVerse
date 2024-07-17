package kr.spring.board.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.board.service.BoardService;
import kr.spring.board.vo.BoardBookmarkVO;
import kr.spring.board.vo.BoardCommentVO;
import kr.spring.board.vo.BoardFavVO;
import kr.spring.board.vo.BoardReFavVO;
import kr.spring.board.vo.BoardResponseFavVO;
import kr.spring.board.vo.BoardResponseVO;
//import kr.spring.board.vo.BoardReplyVO;
//import kr.spring.board.vo.BoardResponseVO;
import kr.spring.board.vo.BoardVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.myPage.service.MyPageService;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BoardAjaxController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private MyPageService myPageService;
	
	/*===================
	 * 부모글 좋아요
	 *===================*/
	//부모글 좋아요 읽기
	@GetMapping("/board/getFav")
	@ResponseBody
	public Map<String,Object> getFav(BoardFavVO fav, HttpSession session){
		log.debug("<<게시판 좋아요 - BoardFavVO>> : " + fav);
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			mapJson.put("status", "noFav");
		}else {
			//로그인된 회원번호 셋팅
			fav.setMem_num(user.getMem_num());
			BoardFavVO boardFav = boardService.selectFav(fav);
			
			if(boardFav != null) {
				mapJson.put("status", "yesFav");
			}else {
				mapJson.put("status", "noFav");
			}
		}
		mapJson.put("count", boardService.selectFavCount(fav.getCb_num()));
		return mapJson;
	}
	
	//부모글 좋아요 등록/삭제
	@PostMapping("/board/writeFav")
	@ResponseBody
	public Map<String,Object> writeFav(BoardFavVO fav, HttpSession session){
		log.debug("<<게시판 좋아요 - 등록>> : " + fav);
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			mapJson.put("result", "logout");
		}else {
			//로그인된 회원번호 셋팅
			fav.setMem_num(user.getMem_num());
			
			BoardFavVO boardFav = boardService.selectFav(fav);
			if(boardFav != null) {
				//등록 -> 삭제
				boardService.deleteFav(fav);
				mapJson.put("status", "noFav");
			}else {
				//등록
				boardService.insertFav(fav);
				mapJson.put("status", "yesFav");
			}
			mapJson.put("result", "success");
			mapJson.put("count", boardService.selectFavCount(fav.getCb_num()));
		}
		return mapJson;
	}
	/*===================
	 * 북마크
	 *===================*/
	@GetMapping("/board/getBM")
	@ResponseBody
	public Map<String,Object> getBM(BoardBookmarkVO bookmark, HttpSession session){
		log.debug("<<게시판 북마크 - BoardBoormarkVO>> : " + bookmark);
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			mapJson.put("status", "noBM");
		}else {
			//로그인된 회원번호 셋팅
			bookmark.setMem_num(user.getMem_num());
			BoardBookmarkVO boardbookmark = boardService.selectBM(bookmark);
			
			if(boardbookmark != null) {
				mapJson.put("status", "yesBM");
			}else {
				mapJson.put("status", "noBM");
			}
		}
		return mapJson;
	}
	
	//북마크 등록/삭제
	@PostMapping("/board/writeBM")
	@ResponseBody
	public Map<String,Object> writeBM(BoardBookmarkVO bookmark, HttpSession session){
		log.debug("<<게시판 북마크 - 등록>> : " + bookmark);
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			mapJson.put("result", "logout");
		}else {
			//로그인된 회원번호 셋팅
			bookmark.setMem_num(user.getMem_num());
			
			BoardBookmarkVO boardbookmark = boardService.selectBM(bookmark);
			if(boardbookmark != null) {
				//등록 -> 삭제
				boardService.deleteBM(bookmark);
				mapJson.put("status", "noBM");
			}else {
				//등록
				boardService.insertBM(bookmark);
				mapJson.put("status", "yesBM");
			}
			mapJson.put("result", "success");
		}
		return mapJson;
	}
	
	/*===================
	 * 부모글 데이터 처리
	 *===================*/
	//업로드 파일 삭제
	/*
	 * @PostMapping("/board/deleteFile")
	 * 
	 * @ResponseBody public Map<String,String> processFile(long cb_num,
	 * HttpSession session, HttpServletRequest request){ Map<String,String> mapJson
	 * = new HashMap<String,String>(); MemberVO user =
	 * (MemberVO)session.getAttribute("user"); if(user == null) {
	 * mapJson.put("result", "logout"); }else { BoardVO db_board =
	 * boardService.selectBoard(cb_num); //로그인한 회원번호와 작성자 회원번호 일치 여부 체크
	 * if(user.getMem_num() != db_board.getMem_num()) { //불일치 mapJson.put("result",
	 * "wrongAccess"); }else { //일치 boardService.deleteFile(cb_num); // 실제삭제
	 * FileUtil.removeFile(request, db_board.getFilename());
	 * 
	 * mapJson.put("result", "success"); } }
	 * 
	 * return mapJson; }
	 */
	
	/*===================
	 * 댓글 등록
	 *===================*/
	@PostMapping("/board/writeComment")
	@ResponseBody
	public Map<String,String> writeReply(BoardCommentVO boardCommentVO, HttpSession session, HttpServletRequest request){
		log.debug("<<댓글 등록>> : " + boardCommentVO);
		
		Map<String,String> mapJson = new HashMap<String,String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			//로그인 안 됨
			mapJson.put("result", "logout");
		}else {
			//회원번호 저장
			boardCommentVO.setMem_num(user.getMem_num());
			//ip 저장
			boardCommentVO.setCc_ip(request.getRemoteAddr());
			
			//댓글 등록
			boardService.insertComment(boardCommentVO);
			mapJson.put("result", "success");
		}
		
		return mapJson;
	}
	
	/*===================
	 * 댓글 목록
	 *===================*/
	@GetMapping("/board/listComment")
	@ResponseBody
	public Map<String,Object> getList(long cb_num, int pageNum, int rowCount, HttpSession session){
		log.debug("<<댓글 목록 - cb_num>> : " + cb_num);
		log.debug("<<댓글 목록 - pageNum>> : " + pageNum);
		log.debug("<<댓글 목록 - rowCount>> : " + rowCount);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("cb_num", cb_num);
		
		//총글의 개수
		int count = boardService.selectRowCountComment(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(pageNum,count,rowCount);
		map.put("start", page.getStartRow());
		map.put("end", page.getEndRow());
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user != null) {
			map.put("mem_num", user.getMem_num());
		}else {
			map.put("mem_num", 0);
		}
		
		List<BoardCommentVO> list = null;
		if(count > 0) {
			list = boardService.selectListComment(map);
		}else {
			list = Collections.emptyList(); // null이 아닌 비어있는 리스트 -> 빈 배열로 인식함
		}
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		mapJson.put("count", count);
		mapJson.put("list", list);
		if(user != null) {
			mapJson.put("user_num", user.getMem_num());
		}
		return mapJson;
	}
	
	/*===================
	 * 댓글 수정
	 *===================*/
	@PostMapping("/board/updateComment")
	@ResponseBody
	public Map<String,String> modifyComment(BoardCommentVO boardCommentVO, HttpSession session, HttpServletRequest request){
		log.debug("<<댓글 수정>> : " + boardCommentVO);
		
		Map<String,String> mapJson = new HashMap<String,String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		BoardCommentVO db_comment = boardService.selectComment(boardCommentVO.getCc_num());
		
		if(user == null) {
			//로그인이 되지 않은 경우
			mapJson.put("result", "logout");
		}else if(user != null && user.getMem_num() == db_comment.getMem_num()) {
			//로그인 회원번호와 작성자 회원번호 일치
			
			//ip 저장
			boardCommentVO.setCc_ip(request.getRemoteAddr());
			//댓글 수정
			boardService.updateComment(boardCommentVO);
			mapJson.put("cc_modify_date",boardService.selectComment(boardCommentVO.getCc_num()).getCc_modify_date());
			mapJson.put("result", "success");
		}else {
			//로그인 회원번호와 작성자 회원번호 불일치
			mapJson.put("result", "wrongAccess");
		}
		
		return mapJson;
	}
	
	/*===================
	 * 댓글 삭제
	 *===================*/
	@PostMapping("/board/deleteComment")
	@ResponseBody
	public Map<String,String> deleteComment(long cc_num, HttpSession session){
		log.debug("<<댓글 삭제 - cc_num>> : " + cc_num);
		
		Map<String,String> mapJson = new HashMap<String,String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		BoardCommentVO db_comment = boardService.selectComment(cc_num);
		if(user == null) {
			//로그인이 되지 않은 경우
			mapJson.put("result", "logout");
		}else if(user != null && user.getMem_num() == db_comment.getMem_num()) {
			//로그인한 회원번호와 작성자 회원번호 일치
			boardService.deleteComment(cc_num);
			mapJson.put("result", "success");
		}else {
			//로그인한 회원번호와 작성자 회원번호 불일치
			mapJson.put("result", "wrongAccess");
		}
		return mapJson;
	}
	
	/*===================
	 * 댓글 좋아요 읽기
	 *===================*/
	@GetMapping("/board/getReFav")
	@ResponseBody
	public Map<String,Object> getReFav(BoardReFavVO fav, HttpSession session){
		log.debug("<<댓글 좋아요>> : " + fav);
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			mapJson.put("result", "success");
			mapJson.put("status", "noFav");
		}else {
			fav.setMem_num(user.getMem_num());
			BoardReFavVO boardReFav = boardService.selectReFav(fav);
			if(boardReFav != null) {
				mapJson.put("result", "success");
				mapJson.put("result", "yesFav");
			}else {
				mapJson.put("result", "success");
				mapJson.put("result", "noFav");
			}
		}
		mapJson.put("count", boardService.selectReFavCount(fav.getCc_num()));
		return mapJson;
	}
	
	/*===================
	 * 댓글 좋아요 등록/삭제	- 토글
	 *===================*/
	@PostMapping("/board/writeReFav")
	@ResponseBody
	public Map<String,Object> writeReFav(BoardReFavVO fav, HttpSession session){
		log.debug("<<댓글 좋아요 등록/삭제>> : " + fav);
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			mapJson.put("result", "logout");
		}else {// 로그인
			fav.setMem_num(user.getMem_num());
			BoardReFavVO boardReFav = boardService.selectReFav(fav);
			if(boardReFav != null) {// 좋아요가 있을 경우 취소
				boardService.deleteReFav(fav);
				mapJson.put("status", "noFav");
			}else {
				boardService.insertReFav(fav);
				mapJson.put("status", "yesFav");
			}
			mapJson.put("result", "success");
					mapJson.put("count", boardService.selectReFavCount(fav.getCc_num()));
		}
		return mapJson;
	}
	/*====================
	 * 답글 클릭시 로그인 확인
	 =====================*/
	@GetMapping("/board/responseLoginCheck")
	@ResponseBody
	public Map<String,Object> respLoginCheck(HttpSession session){
		log.debug("<<답글 클릭 로그인 확인>> : ");
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		if(user == null) {
			mapJson.put("result","logout");
		}else {
			user.setMem_nickname(myPageService.selectMember(user.getMem_num()).getMem_nickName());
			String name = "";
			if(user.getMem_nickname() != null) {
				name = user.getMem_nickname();
			}else {
				name = user.getMem_id();
			}
			
			mapJson.put("result", "login");
			mapJson.put("user_num", user.getMem_num());
			mapJson.put("name", name);
			
		}
		return mapJson;
	}
	
	
	/*====================
	 * 답글 등록
	 =====================*/
	@PostMapping("/board/writeResponse")
	@ResponseBody
	public Map<String,String> writeResponse(BoardResponseVO boardResponseVO, HttpSession session, HttpServletRequest request){
		log.debug("<<답글 등록>> : " + boardResponseVO);
		
		Map<String,String> mapJson = new HashMap<String,String>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			//로그인이 되지 않은 경우
			mapJson.put("result", "logout");
		}else {
			//회원번호 저장
			boardResponseVO.setMem_num(user.getMem_num());
			//ip 저장
			boardResponseVO.setTe_ip(request.getRemoteAddr());
			//답글 등록
			boardService.insertResponse(boardResponseVO);
			mapJson.put("result", "success");
		}
		
		return mapJson;
	}
	
	/*====================
	 * 답글 목록
	 =====================*/
	@GetMapping("/board/getListResp")
	@ResponseBody
	public Map<String, Object> getListResp(long cc_num, HttpSession session) {
	    log.debug("<<답글 목록 - cc_num>> : " + cc_num);

	    List<BoardResponseVO> list = boardService.selectListResponse(cc_num);
	    MemberVO user = (MemberVO) session.getAttribute("user");

	    Map<String, Object> mapJson = new HashMap<>();
	    
	    for (BoardResponseVO response : list) {
//	        // 각 답글에 대한 좋아요 개수 읽어서 지정해줌 response vo에 respfav_cnt 세팅함
//	        int favCount = boardService.selectResponseFavCnt(response.getTe_num());
//	        response.setRespfav_cnt(favCount);
	    }
	    
	    mapJson.put("list", list);

	    if (user != null) {
	        mapJson.put("user_num", user.getMem_num());
	    }

	    return mapJson;
	}

	
	/*====================
	 * 답글 수정
	 =====================*/
	@PostMapping("/board/updateResponse")
	@ResponseBody
	public Map<String,String> modifyResponse(BoardResponseVO boardResponseVO, HttpSession session, HttpServletRequest request){
		log.debug("<<답글 수정>> : " + boardResponseVO);
		
		Map<String,String> mapJson = new HashMap<String,String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		BoardResponseVO db_response = boardService.selectResponse(boardResponseVO.getTe_num());
		if(user == null) {
			//로그인이 되지 않은 경우
			mapJson.put("result", "logout");
		}else if(user != null && user.getMem_num() == db_response.getMem_num()) {
			//로그인 회원번호와 작성자 회원번호 일치
			//ip 저장
			boardResponseVO.setTe_ip(request.getRemoteAddr());
			//답글 수정
			boardService.updateResponse(boardResponseVO);
			mapJson.put("resp_modify_date",boardService.selectResponse(boardResponseVO.getTe_num()).getTe_mdate());
			mapJson.put("result", "success");
		}else {
			//로그인 회원번호와 작성자 회원번호 불일치
			mapJson.put("result", "wrongAccess");
		}
		return mapJson;
	}
	
	/*====================
	 * 답글 삭제
	 =====================*/
	@PostMapping("/board/deleteResponse")
	@ResponseBody
	public Map<String,Object> deleteResponse(long te_num, long mem_num, HttpSession session){
		log.debug("<<답글 삭제 - te_num>> : " + te_num);
		log.debug("<<답글 삭제 - mem_num>> : " + mem_num);
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			//로그인이 되지 않은 경우
			mapJson.put("result", "logout");
		}else if(user != null && user.getMem_num() == mem_num) {
			//로그인 회원번호와 작성자 회원번호 일치
			//cc_num 구하기
			BoardResponseVO response = boardService.selectResponse(te_num);
			//답글 삭제
			boardService.deleteResponse(te_num);
			int cnt = boardService.selectResponseCount(response.getCc_num());
			log.debug("<<답글 삭제 후 나머지 답글 개수>> : " + cnt);
			
			mapJson.put("cnt", cnt);
			mapJson.put("result", "success");
		}else {
			//로그인 회원번호와 작성자 회원번호 불일치
			mapJson.put("result", "wrongAccess");
		}
		return mapJson;
	}
	
}
