package kr.spring.board.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.board.vo.BoardFavVO;
import kr.spring.board.vo.BoardReFavVO;
import kr.spring.board.vo.BoardResponseFavVO;
import kr.spring.board.vo.BoardResponseVO;
import kr.spring.board.vo.BoardCommentVO;
import kr.spring.board.vo.BoardVO;

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
	
	//댓글
	public List<BoardCommentVO> selectListComment(Map<String,Object> map);
	public Integer selectRowCountComment(Map<String,Object> map);
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
	public List<BoardResponseVO> selectListResponse(Long re_num);
	public BoardResponseVO selectResponse(Long te_num);
	public void insertResponse(BoardResponseVO boardResponse);
	public void updateResponse(BoardResponseVO boardResponse);
	public void deleteResponse(Long te_num);
	//답글의 개수 구하기
	public Integer selectResponseCount(Long cc_num);
	// 답글 좋아요 가져오기
	public BoardResponseFavVO selectResponseFav(BoardResponseFavVO boardResponseFav);
	// 답글의 좋아요 개수 구하기
	public Integer selectResponseFavCnt(Long te_num);



}
