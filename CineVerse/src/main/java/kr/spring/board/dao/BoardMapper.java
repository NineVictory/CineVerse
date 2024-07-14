package kr.spring.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.board.vo.BoardFavVO;
import kr.spring.board.vo.BoardReFavVO;
import kr.spring.board.vo.BoardResponseVO;
import kr.spring.board.vo.BoardCommentVO;
import kr.spring.board.vo.BoardVO;

@Mapper
public interface BoardMapper {
	//부모글
	public List<BoardVO> selectList(Map<String,Object> map);
	public Integer selectRowCount(Map<String,Object> map);
	public void insertBoard(BoardVO board);
	@Select("SELECT * FROM community_board JOIN member USING(mem_num) LEFT OUTER JOIN member_detail USING(mem_num) WHERE cb_num=#{cb_num}")
	public BoardVO selectBoard(Long cb_num);
	@Update("UPDATE community_board SET cb_hit=cb_hit+1 WHERE cb_num=#{cb_num}")
	public void updateHit(Long cb_num);
	public void updateBoard(BoardVO board);
	
	@Delete("DELETE FROM community_board WHERE cb_num=#{cb_num}")
	public void deleteBoard(Long cb_num);
	
	@Update("UPDATE community_board SET filename='' WHERE cb_num=#{cb_num}")
	public void deleteFile(Long cb_num);// 파일만 삭제
	
	
	//부모글 좋아요
	@Select("SELECT * FROM community_fav WHERE cb_num = #{cb_num} AND mem_num = #{mem_num}")
	public BoardFavVO selectFav(BoardFavVO fav);
	@Select("SELECT COUNT(*) FROM community_fav WHERE cb_num = #{cb_num}")
	public Integer selectFavCount(Long cb_num);
	@Insert("INSERT INTO community_fav (cb_num, mem_num) VALUES (#{cb_num}, #{mem_num})")
	public void insertFav(BoardFavVO fav);
	@Delete("DELETE FROM community_fav WHERE cb_num=#{cb_num} AND mem_num=#{mem_num}")
	public void deleteFav(BoardFavVO fav);
	@Delete("DELETE FROM community_fav WHERE cb_num = #{cb_num}")
	public void deleteFavByBoardNum(Long cb_num);
		
	
	//댓글
	public List<BoardCommentVO> selectListComment(Map<String,Object> map);
	@Select("SELECT COUNT(*) FROM community_comment WHERE cb_num=#{cb_num}")
	public Integer selectRowCountComment(Map<String,Object> map);
	//댓글 수정,삭제시 작성자 회원번호를 구하기 위해 사용
	@Select("SELECT * FROM community_comment WHERE cc_num=#{cc_num}")
	public BoardCommentVO selectComment(Long cc_num);
	public void insertComment(BoardCommentVO boardComment);				//cc_ip 컬럼 추가할 것
	@Update("UPDATE community_comment SET cc_content=#{cc_content},cc_ip=#{cc_ip},cc_modify_date=SYSDATE WHERE cc_num=#{cc_num}")
	public void updateComment(BoardCommentVO boardComment);
	@Delete("DELETE FROM community_comment WHERE cc_num=#{cc_num}")
	public void deleteComment(Long cc_num);
	//부모글 삭제시 댓글이 존재하면 부모글 삭제전 댓글 삭제
	@Delete("DELETE FROM community_comment WHERE cb_num=#{cb_num}")
	public void deleteCommentByBoardNum(Long cb_num);
	
	
	//댓글 좋아요
	@Select("SELECT * FROM community_comment_fav WHERE cc_num=#{cc_num} AND mem_num=#{mem_num}")
	public BoardReFavVO selectReFav(BoardReFavVO fav);
	@Select("SELECT COUNT(*) FROM community_comment_fav WHERE cc_num=#{cc_num}")
	public Integer selectReFavCount(Long cc_num);
	@Insert("INSERT INTO community_comment_fav (cc_num,mem_num) VALUES (#{cc_num},#{mem_num})")
	public void insertReFav(BoardReFavVO fav);
	@Delete("DELETE FROM community_comment_fav WHERE cc_num=#{cc_num} AND mem_num=#{mem_num}")
	public void deleteReFav(BoardReFavVO fav);
	@Delete("DELETE FROM community_comment_fav WHERE cc_num=#{cc_num}")
	public void deleteReFavByReNum(Long cc_num);
	@Delete("DELETE FROM community_comment_fav WHERE cc_num IN (SELECT cc_num FROM community_comment WHERE cb_num=#{cb_num})")
	public void deleteReFavByBoardNum(Long cb_num);
	
	
	//답글
	public List<BoardResponseVO> selectListResponse(Long cc_num);
	@Select("SELECT * FROM community_response WHERE te_num=#{te_num}")
	public BoardResponseVO selectResponse(Long te_num);
	public void insertResponse(BoardResponseVO boardResponse);
	@Update("UPDATE community_response SET te_content=#{te_content},te_ip=#{te_ip},te_mdate=SYSDATE WHERE te_num=#{te_num}")
	public void updateResponse(BoardResponseVO boardResponse);
	public void deleteResponse(Long te_num);
	//댓글 삭제시 자식글인 답글을 모두 삭제
	@Delete("DELETE FROM community_response WHERE cc_num=#{cc_num}")
	public void deleteResponseByReNum(Long cc_num);	
	//부모글 삭제시 댓글의 답글이 존재하면 댓글 번호를 구해서 답글 삭제
	@Delete("DELETE FROM community_response WHERE cc_num IN (SELECT cc_num FROM community_comment WHERE cb_num=#{cb_num})")
	public void deleteResponseByBoardNum(Long cb_num);
	//답글의 개수 구하기
	@Select("SELECT COUNT(*) FROM community_response WHERE cc_num=#{cc_num}")
	public Integer selectResponseCount(Long cc_num);

	
}
