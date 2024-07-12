package kr.spring.board.service;

import java.util.List;
import java.util.Map;

import kr.spring.board.vo.BoardFavVO;
import kr.spring.board.vo.BoardReFavVO;
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
	public void deleteReFavByReNum(Long cc_num);
	public void deleteReFavByBoardNum(Long cb_num);
}
