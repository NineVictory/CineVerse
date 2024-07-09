package kr.spring.assignment.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;

import kr.spring.assignment.vo.AssignVO;


public interface AssignBoardService {
	//부모글
	public List<AssignVO> a_selectList(Map<String,Object> map);
	public Integer a_selectRowCount(Map<String,Object> map);
	public void a_insertBoard(AssignVO assign);
	public AssignVO a_selectBoard(Long ab_num);
	public void a_updateHit(Long ab_num);
	public void a_updateBoard(AssignVO assign);
	public void a_deleteBoard(Long ab_num);
	public void a_deleteFile(Long ab_num);// 파일만 삭제
	
	/*
	 * //부모글 북마크 public BoardFavVO selectFav(BoardFavVO fav); public Integer
	 * selectFavCount(Long board_num); public void insertFav(BoardFavVO fav); public
	 * void deleteFav(BoardFavVO fav);
	 * 
	 * //댓글 public List<BoardReplyVO> selectListReply(Map<String,Object> map);
	 * public Integer selectRowCountReply(Map<String,Object> map); public
	 * BoardReplyVO selectReply(Long re_num); public void insertReply(BoardReplyVO
	 * boardReply); public void updateReply(BoardReplyVO boardReply); public void
	 * deleteReply(Long re_num);
	 * 
	 * //댓글 좋아요 public BoardReFavVO selectReFav(BoardReFavVO fav); public Integer
	 * selectReFavCount(Long re_num); public void insertReFav(BoardReFavVO fav);
	 * public void deleteReFav(BoardReFavVO fav); public void
	 * deleteReFavByReNum(Long re_num); public void deleteReFavByBoardNum(Long
	 * board_num);
	 * 
	 * //답글 public List<BoardResponseVO> selectListResponse(Long re_num); public
	 * BoardResponseVO selectResponse(Long te_num); public void
	 * insertResponse(BoardResponseVO boardResponse); public void
	 * updateResponse(BoardResponseVO boardResponse); public void
	 * deleteResponse(Long te_num);
	 */
	
}
