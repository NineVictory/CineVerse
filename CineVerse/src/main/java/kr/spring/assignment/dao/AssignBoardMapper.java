package kr.spring.assignment.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.assignment.vo.AssignFavVO;
import kr.spring.assignment.vo.AssignVO;
import kr.spring.board.vo.BoardFavVO;



@Mapper
public interface AssignBoardMapper {
	//부모글
	public List<AssignVO> ab_selectList(Map<String,Object> map);
	public Integer ab_selectRowCount(Map<String,Object> map);
	public void ab_insertBoard(AssignVO assign);

	/*
	 * @Select("SELECT * FROM assignment_board JOIN member USING(mem_num) LEFT OUTER JOIN member_detail USING(mem_num) WHERE ab_num=#{ab_num}"
	 */	public AssignVO ab_selectBoard(Long ab_num);
	@Update("UPDATE assignment_board SET ab_hit=ab_hit+1 WHERE ab_num=#{ab_num}")
	public void ab_updateHit(Long ab_num);
	public void ab_updateBoard(AssignVO assign);
	
	@Delete("DELETE FROM assignment_board WHERE ab_num=#{ab_num}")
	public void ab_deleteBoard(Long ab_num);
	
	@Update("UPDATE assignment_board SET filename='' WHERE ab_num=#{ab_num}")
	public void ab_deleteFile(Long ab_num);// 파일만 삭제
	
	//부모글 좋아요
	@Select("SELECT * FROM ab_bookmark WHERE ab_num = #{ab_num} AND mem_num = #{mem_num}")
	public AssignFavVO ab_selectFav(AssignFavVO fav);
	@Select("SELECT COUNT(*) FROM ab_bookmark WHERE ab_num = #{ab_num}")
	public Integer ab_selectFavCount(Long ab_num);
	@Insert("INSERT INTO ab_bookmark (ab_num, mem_num) VALUES (#{ab_num}, #{mem_num})")
	public void ab_insertFav(AssignFavVO fav);
	@Delete("DELETE FROM ab_bookmark WHERE ab_num=#{ab_num} AND mem_num=#{mem_num}")
	public void ab_deleteFav(AssignFavVO fav);
	@Delete("DELETE FROM ab_bookmark WHERE ab_num = #{ab_num}")
	public void ab_deleteFavByBoardNum(Long ab_num);
}
