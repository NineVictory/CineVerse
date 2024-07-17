package kr.spring.assignment.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.assignment.dao.AssignBoardMapper;
import kr.spring.assignment.vo.AssignFavVO;
import kr.spring.assignment.vo.AssignVO;

@Service
@Transactional
public class AssignServiceImpl implements AssignService{

	@Autowired
	AssignBoardMapper assignBoardMapper;
	
	@Override
	public List<AssignVO> ab_selectList(Map<String, Object> map) {
		return assignBoardMapper.ab_selectList(map);
	}

	@Override
	public Integer ab_selectRowCount(Map<String, Object> map) {
		return assignBoardMapper.ab_selectRowCount(map);
	}

	@Override
	public void ab_insertBoard(AssignVO assign) {
		assignBoardMapper.ab_insertBoard(assign);
	}

	@Override
	public AssignVO ab_selectBoard(Long ab_num) {
		return assignBoardMapper.ab_selectBoard(ab_num);
	}

	@Override
	public void ab_updateHit(Long ab_num) {
		assignBoardMapper.ab_updateHit(ab_num);
	}

	@Override
	public void ab_updateBoard(AssignVO assign) {
		assignBoardMapper.ab_updateBoard(assign);
	}

	@Override
	public void ab_deleteBoard(Long ab_num) {
		assignBoardMapper.ab_deleteFavByBoardNum(ab_num);
		assignBoardMapper.ab_deleteBoard(ab_num);
	}

	@Override
	public void ab_deleteFile(Long ab_num) {
		assignBoardMapper.ab_deleteFile(ab_num);
	}

	@Override
	public AssignFavVO ab_selectFav(AssignFavVO fav) {
		return assignBoardMapper.ab_selectFav(fav);
	}

	@Override
	public Integer ab_selectFavCount(Long ab_num) {
		return assignBoardMapper.ab_selectFavCount(ab_num);
	}

	@Override
	public void ab_insertFav(AssignFavVO fav) {
		assignBoardMapper.ab_insertFav(fav);
	}

	@Override
	public void ab_deleteFav(AssignFavVO fav) {
		assignBoardMapper.ab_deleteFav(fav);
	}

}
