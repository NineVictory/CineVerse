package kr.spring.admin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.admin.vo.AdminVO;
import kr.spring.admin.vo.EventVO;
import kr.spring.board.vo.BoardVO;

@Mapper
public interface AdminMapper {
    // 회원 관리
    @Select("SELECT m.mem_num, m.mem_id, m.mem_auth, m.mem_rank, m.mem_membership, "
            + "md.mem_name, md.mem_phone, md.mem_email, md.mem_reg_date "
            + "FROM member m "
            + "JOIN member_detail md ON m.mem_num = md.mem_num WHERE m.mem_auth = 3 ORDER BY md.mem_reg_date DESC")
    public List<AdminVO> getAllMembers();
    
    public void updateAuth(long mem_num, long mem_auth);
    
    // 구독 맴버십
    @Select("SELECT m.mem_num, m.mem_id, m.mem_rank, m.mem_membership, md.mem_name, md.mem_reg_date "
    		+ "FROM member m Join member_detail md "
    		+ "ON m.mem_num = md.mem_num WHERE m.mem_membership = 1 ORDER BY md.mem_reg_date DESC")
    public List<AdminVO> getAllMembership();
    // 공지사항

    
    // 이벤트
    @Select("SELECT event_num, event_name, event_start, event_end, event_reg_date "
    		+ "FROM event "
    		+ "ORDER BY event_reg_date DESC")
    public List<EventVO> getAllEvent();
    public void insertEvent(EventVO eventVO);
	
    // 결제
    
    // 상품
    

}
