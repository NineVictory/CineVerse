package kr.spring.assignment.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.assignment.vo.AssignVO;



@Mapper
public interface AssignBoardMapper {
	//부모글
	public List<AssignVO> ab_selectList(Map<String,Object> map);
	public Integer ab_selectRowCount(Map<String,Object> map);
	public void ab_insertBoard(AssignVO assign);
	@Select("SELECT * FROM assignment_board JOIN member USING(mem_num) LEFT OUTER JOIN member_detail USING(mem_num) WHERE ab_num=#{ab_num}")
	public AssignVO ab_selectBoard(Long ab_num);
	@Update("UPDATE assignment_board SET ab_hit=ab_hit+1 WHERE ab_num=#{ab_num}")
	public void ab_updateHit(Long ab_num);
	public void ab_updateBoard(AssignVO assign);
	
	@Delete("DELETE FROM assignment_board WHERE ab_num=#{ab_num}")
	public void ab_deleteBoard(Long ab_num);
	
	@Update("UPDATE assignment_board SET filename='' WHERE ab_num=#{ab_num}")
	public void ab_deleteFile(Long ab_num);// 파일만 삭제
	
	
}
