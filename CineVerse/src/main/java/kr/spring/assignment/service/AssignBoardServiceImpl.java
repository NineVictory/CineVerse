package kr.spring.assignment.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.assignment.dao.AssignBoardMapper;
import kr.spring.assignment.vo.AssignVO;



@Service
@Transactional
public class AssignBoardServiceImpl implements AssignBoardService{

	@Autowired
	AssignBoardMapper assignboardMapper;
	
	@Override
	public List<AssignVO> a_selectList(Map<String, Object> map) {
		return assignboardMapper.a_selectList(map);
	}

	@Override
	public Integer a_selectRowCount(Map<String, Object> map) {
		return assignboardMapper.a_selectRowCount(map);
	}

	@Override
	public void a_insertBoard(AssignVO assign) {
		assignboardMapper.a_insertBoard(assign);	
	}

	@Override
	public AssignVO a_selectBoard(Long board_num) {
		return assignboardMapper.a_selectBoard(board_num);
	}

	@Override
	public void a_updateHit(Long board_num) {
		assignboardMapper.a_updateHit(board_num);		
	}

	@Override
	public void a_updateBoard(AssignVO board) {
		assignboardMapper.a_updateBoard(board);
	}

	@Override
	public void a_deleteBoard(Long ab_num) {
		//답글 삭제
		//assignboardMapper.deleteResponseByBoardNum(ab_num);
		//댓글 좋아요 삭제
		//assignboardMapper.deleteReFavByBoardNum(ab_num);
		//댓글 삭제
		//assignboardMapper.deleteReplyByBoardNum(ab_num);
		//부모글 좋아요 삭제
		//assignboardMapper.deleteFavByBoardNum(ab_num);
		//부모글 삭제
		assignboardMapper.a_deleteBoard(ab_num);
	}

	@Override
	public void a_deleteFile(Long ab_num) {
		assignboardMapper.a_deleteFile(ab_num);
	}
	
	/*
	 * @Override public BoardFavVO selectFav(BoardFavVO fav) { return
	 * assignboardMapper.selectFav(fav); }
	 * 
	 * @Override public Integer selectFavCount(Long board_num) { return
	 * assignboardMapper.selectFavCount(board_num); }
	 * 
	 * @Override public void insertFav(BoardFavVO fav) { assignboardMapper.insertFav(fav);
	 * }
	 * 
	 * @Override public void deleteFav(BoardFavVO fav) { assignboardMapper.deleteFav(fav);
	 * }
	 * 
	 * @Override public List<BoardReplyVO> selectListReply(Map<String, Object> map)
	 * { return assignboardMapper.selectListReply(map); }
	 * 
	 * @Override public Integer selectRowCountReply(Map<String, Object> map) {
	 * return assignboardMapper.selectRowCountReply(map); }
	 * 
	 * @Override public BoardReplyVO selectReply(Long re_num) { return
	 * assignboardMapper.selectReply(re_num); }
	 * 
	 * @Override public void insertReply(BoardReplyVO boardReply) {
	 * assignboardMapper.insertReply(boardReply); }
	 * 
	 * @Override public void updateReply(BoardReplyVO boardReply) {
	 * assignboardMapper.updateReply(boardReply);
	 * 
	 * }
	 * 
	 * @Override public void deleteReply(Long re_num) { //답글 삭제
	 * assignboardMapper.deleteResponseByReNum(re_num); //댓글 좋아요
	 * assignboardMapper.deleteReFavByReNum(re_num); boardMapper.deleteReply(re_num); }
	 * 
	 * @Override public BoardReFavVO selectReFav(BoardReFavVO fav) { return
	 * assignboardMapper.selectReFav(fav); }
	 * 
	 * @Override public Integer selectReFavCount(Long re_num) { return
	 * assignboardMapper.selectReFavCount(re_num); }
	 * 
	 * @Override public void insertReFav(BoardReFavVO fav) {
	 * assignboardMapper.insertReFav(fav); }
	 * 
	 * @Override public void deleteReFav(BoardReFavVO fav) {
	 * assignboardMapper.deleteReFav(fav); }
	 * 
	 * @Override public void deleteReFavByReNum(Long re_num) {
	 * 
	 * }
	 * 
	 * @Override public void deleteReFavByBoardNum(Long board_num) { // TODO
	 * Auto-generated method stub
	 * 
	 * }
	 * 
	 * @Override public List<BoardResponseVO> selectListResponse(Long re_num) {
	 * return assignboardMapper.selectListResponse(re_num); }
	 * 
	 * @Override public BoardResponseVO selectResponse(Long te_num) { // TODO
	 * Auto-generated method stub return null; }
	 * 
	 * @Override public void insertResponse(BoardResponseVO boardResponse) {
	 * assignboardMapper.insertResponse(boardResponse); }
	 * 
	 * @Override public void updateResponse(BoardResponseVO boardResponse) { // TODO
	 * Auto-generated method stub
	 * 
	 * }
	 * 
	 * @Override public void deleteResponse(Long te_num) { // TODO Auto-generated
	 * method stub
	 * 
	 * }
	 */
}
