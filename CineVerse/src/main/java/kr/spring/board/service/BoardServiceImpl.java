package kr.spring.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.board.dao.BoardMapper;
import kr.spring.board.vo.BoardFavVO;
import kr.spring.board.vo.BoardReFavVO;
import kr.spring.board.vo.BoardReplyVO;
import kr.spring.board.vo.BoardVO;

@Service
@Transactional
public class BoardServiceImpl implements BoardService{

	@Autowired
	BoardMapper boardMapper;
	
	@Override
	public List<BoardVO> selectList(Map<String, Object> map) {
		return boardMapper.selectList(map);
	}

	@Override
	public Integer selectRowCount(Map<String, Object> map) {
		return boardMapper.selectRowCount(map);
	}

	@Override
	public void insertBoard(BoardVO board) {
		boardMapper.insertBoard(board);	
	}

	@Override
	public BoardVO selectBoard(Long cb_num) {
		return boardMapper.selectBoard(cb_num);
	}

	@Override
	public void updateHit(Long cb_num) {
		boardMapper.updateHit(cb_num);		
	}

	@Override
	public void updateBoard(BoardVO board) {
		boardMapper.updateBoard(board);
	}

	@Override
	public void deleteBoard(Long cb_num) {
		//답글 삭제
		//댓글 좋아요 삭제
		boardMapper.deleteReFavByBoardNum(cb_num);
		//댓글 삭제
		boardMapper.deleteReplyByBoardNum(cb_num);
		//부모글 좋아요 삭제
		boardMapper.deleteFavByBoardNum(cb_num);
		//부모글 삭제
		boardMapper.deleteBoard(cb_num);
	}

	@Override
	public void deleteFile(Long cb_num) {
		boardMapper.deleteFile(cb_num);
	}

	@Override
	public BoardFavVO selectFav(BoardFavVO fav) {
		return boardMapper.selectFav(fav);
	}

	@Override
	public Integer selectFavCount(Long cb_num) {
		return boardMapper.selectFavCount(cb_num);
	}

	@Override
	public void insertFav(BoardFavVO fav) {
		boardMapper.insertFav(fav);
	}

	@Override
	public void deleteFav(BoardFavVO fav) {
		boardMapper.deleteFav(fav);
	}

	@Override
	public List<BoardReplyVO> selectListReply(Map<String, Object> map) {
		return boardMapper.selectListReply(map);
	}

	@Override
	public Integer selectRowCountReply(Map<String, Object> map) {
		return boardMapper.selectRowCountReply(map);
	}

	@Override
	public BoardReplyVO selectReply(Long re_num) {
		return boardMapper.selectReply(re_num);
	}

	@Override
	public void insertReply(BoardReplyVO boardReply) {
		boardMapper.insertReply(boardReply);
	}

	@Override
	public void updateReply(BoardReplyVO boardReply) {
		boardMapper.updateReply(boardReply);
		
	}

	@Override
	public void deleteReply(Long re_num) {
		//답글
		//댓글 좋아요
		boardMapper.deleteReFavByReNum(re_num);
		boardMapper.deleteReply(re_num);
	}

	@Override
	public BoardReFavVO selectReFav(BoardReFavVO fav) {
		return boardMapper.selectReFav(fav);
	}

	@Override
	public Integer selectReFavCount(Long re_num) {
		return boardMapper.selectReFavCount(re_num);
	}

	@Override
	public void insertReFav(BoardReFavVO fav) {
		boardMapper.insertReFav(fav);
	}

	@Override
	public void deleteReFav(BoardReFavVO fav) {
		boardMapper.deleteReFav(fav);
	}

	@Override
	public void deleteReFavByReNum(Long re_num) {
		
	}

	@Override
	public void deleteReFavByBoardNum(Long board_num) {
		// TODO Auto-generated method stub
		
	}
}
