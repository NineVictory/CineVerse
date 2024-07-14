package kr.spring.assignment.service;

import java.util.List;
import java.util.Map;

import kr.spring.assignment.vo.AssignVO;

public interface AssignService {
	//부모글
	public List<AssignVO> ab_selectList(Map<String,Object> map);
	public Integer ab_selectRowCount(Map<String,Object> map);
	public void ab_insertBoard(AssignVO assign);
	public AssignVO ab_selectBoard(Long ab_num);
	public void ab_updateHit(Long ab_num);
	public void ab_updateBoard(AssignVO assign);
	public void ab_deleteBoard(Long ab_num);
	public void ab_deleteFile(Long ab_num);// 파일만 삭제
}
