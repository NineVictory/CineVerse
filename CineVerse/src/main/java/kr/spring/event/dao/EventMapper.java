package kr.spring.event.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.event.vo.EventPVO;
import kr.spring.event.vo.UserEventVO;


@Mapper
public interface EventMapper {
	
	public Integer selectEventRowCount(Map<String,Object> map);
	
	public List<UserEventVO> selectEventList(Map<String,Object> map);
	
	@Select("SELECT * FROM event WHERE event_num=#{event_num}")
	public UserEventVO selectEvent(long event_num);
	
	@Select("SELECT * FROM event_participation WHERE event_num=#{event_num} AND mem_num=#{mem_num}")
	public EventPVO selectParticipation(EventPVO eventP);
	
	public void insertParticipation(EventPVO eventP);
	
	public void insertCrowd(EventPVO eventP);
}
