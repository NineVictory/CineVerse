package kr.spring.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.board.dao.BoardMapper;
import kr.spring.board.vo.BoardFavVO;
import kr.spring.board.vo.BoardReFavVO;
import kr.spring.board.vo.BoardResponseFavVO;
import kr.spring.board.vo.BoardResponseVO;
import kr.spring.board.vo.BoardBookmarkVO;
import kr.spring.board.vo.BoardCommentVO;
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
		boardMapper.deleteResponseByBoardNum(cb_num);
		//댓글 좋아요 삭제
		boardMapper.deleteReFavByBoardNum(cb_num);
		//댓글 삭제
		boardMapper.deleteCommentByBoardNum(cb_num);
		//부모글 좋아요 삭제
		boardMapper.deleteFavByBoardNum(cb_num);
		//북마크 삭제
		boardMapper.deleteBMByBoardNum(cb_num);
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
	public List<BoardCommentVO> selectListComment(Map<String, Object> map) {
		return boardMapper.selectListComment(map);
	}

	@Override
	public Integer selectRowCountComment(Long cb_num) {
		return boardMapper.selectRowCountComment(cb_num);
	}

	@Override
	public BoardCommentVO selectComment(Long cc_num) {
		return boardMapper.selectComment(cc_num);
	}

	@Override
	public void insertComment(BoardCommentVO boardComment) {
		boardMapper.insertComment(boardComment);
	}

	@Override
	public void updateComment(BoardCommentVO boardComment) {
		boardMapper.updateComment(boardComment);
		
	}

	@Override
	public void deleteComment(Long cc_num) {
		//답글
		boardMapper.deleteResponseByReNum(cc_num);
		//댓글 좋아요
		boardMapper.deleteReFavByReNum(cc_num);
		boardMapper.deleteComment(cc_num);
	}

	@Override
	public BoardReFavVO selectReFav(BoardReFavVO fav) {
		return boardMapper.selectReFav(fav);
	}

	@Override
	public Integer selectReFavCount(Long cc_num) {
		return boardMapper.selectReFavCount(cc_num);
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
	public List<BoardResponseVO> selectListResponse(Long cc_num) {
		return boardMapper.selectListResponse(cc_num);
	}

	@Override
	public BoardResponseVO selectResponse(Long te_num) {
		return boardMapper.selectResponse(te_num);
	}

	@Override
	public void insertResponse(BoardResponseVO boardResponse) {
		boardMapper.insertResponse(boardResponse);
	}

	@Override
	public void updateResponse(BoardResponseVO boardResponse) {
		boardMapper.updateResponse(boardResponse);
	}

	@Override
	public void deleteResponse(Long te_num) {
		boardMapper.deleteResponse(te_num);
	}

	@Override
	public Integer selectResponseCount(Long cc_num) {
		return boardMapper.selectResponseCount(cc_num);
	}

	@Override
	public Integer selectResponseFavCnt(Long te_num) {
		return boardMapper.selectResponseFavCnt(te_num);
	}

	@Override
	public BoardResponseFavVO selectResponseFav(BoardResponseFavVO boardResponseFav) {
		return boardMapper.selectResponseFav(boardResponseFav);
	}

	@Override
	public BoardBookmarkVO selectBM(BoardBookmarkVO bookmark) {
		return boardMapper.selectBM(bookmark);
	}

	@Override
	public void insertBM(BoardBookmarkVO bookmark) {
		boardMapper.insertBM(bookmark);
	}

	@Override
	public void deleteBM(BoardBookmarkVO bookmark) {
		boardMapper.deleteBM(bookmark);
	}

	@Override
	public Integer selectResponseCountByCbNum(Long cb_num) {
		return boardMapper.selectResponseCountByCbNum(cb_num);
	}

}
