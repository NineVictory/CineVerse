package kr.spring.board.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.board.vo.BoardFavVO;
import kr.spring.board.vo.BoardReFavVO;
import kr.spring.board.vo.BoardReportVO;
import kr.spring.board.vo.BoardResponseFavVO;
import kr.spring.board.vo.BoardResponseVO;
import kr.spring.board.vo.BoardBookmarkVO;
import kr.spring.board.vo.BoardCommentVO;
import kr.spring.board.vo.BoardVO;
import kr.spring.board.vo.CommentReportVO;
import kr.spring.board.vo.ResponseReportVO;

public interface BoardService {
	//부모글
	public List<BoardVO> selectList(Map<String,Object> map);
	public Integer selectRowCount(Map<String,Object> map);
	public void insertBoard(BoardVO board);
	public BoardVO selectBoard(Long cb_num);
	public void updateHit(Long cb_num);
	public void updateBoard(BoardVO board);
	public void deleteBoard(Long cb_num);
	public void deleteFile(Long cb_num);// 파일만 삭제
	
	//부모글 좋아요
	public BoardFavVO selectFav(BoardFavVO fav);
	public Integer selectFavCount(Long cb_num);
	public void insertFav(BoardFavVO fav);
	public void deleteFav(BoardFavVO fav);
	
	//북마크
	public BoardBookmarkVO selectBM(BoardBookmarkVO bookmark);
	public void insertBM(BoardBookmarkVO bookmark);
	public void deleteBM(BoardBookmarkVO bookmark);
	
	//댓글
	public List<BoardCommentVO> selectListComment(Map<String,Object> map);
	public Integer selectRowCountComment(Long cb_num);
	public BoardCommentVO selectComment(Long cc_num);
	public void insertComment(BoardCommentVO boardComment);
	public void updateComment(BoardCommentVO boardComment);
	public void deleteComment(Long cc_num);
	
	//댓글 좋아요
	public BoardReFavVO selectReFav(BoardReFavVO fav);
	public Integer selectReFavCount(Long cc_num);
	public void insertReFav(BoardReFavVO fav);
	public void deleteReFav(BoardReFavVO fav);

	//답글
	public List<BoardResponseVO> selectListResponse(Map<String,Object> mapm);
	public BoardResponseVO selectResponse(Long te_num);
	public void insertResponse(BoardResponseVO boardResponse);
	public void updateResponse(BoardResponseVO boardResponse);
	public void deleteResponse(Long te_num);
	//답글의 개수 구하기
	public Integer selectResponseCount(Long cc_num);
	
	//게시글의 답글 총 개수
	public Integer selectResponseCountByCbNum(Long cb_num);
	
	//답글 좋아요
	public BoardResponseFavVO selectRespFav(BoardResponseFavVO respFav);
	public Integer selectRespFavCount(Long te_num);
	public void insertRespFav(BoardResponseFavVO respfav);
	public void deleteRespFav(BoardResponseFavVO respfav);
	
	
	//부모글 신고
	public void boardReport(BoardReportVO boardReportVO);
	
	//댓글 신고
	public void commentReport(CommentReportVO commentReportVO);
		
	//답글 신고
	public void responseReport(ResponseReportVO responseReportVO);
}
