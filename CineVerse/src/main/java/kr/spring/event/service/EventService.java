package kr.spring.event.service;

import java.util.List;
import java.util.Map;

import kr.spring.event.vo.EventPVO;
import kr.spring.event.vo.UserEventVO;

public interface EventService {
	public Integer selectEventRowCount(Map<String,Object> map);
	
	public List<UserEventVO> selectEventList(Map<String,Object> map);
	
	public UserEventVO selectEvent(long event_num);
	
	public EventPVO selectParticipation(EventPVO eventP);
	
	public void insertParticipation(EventPVO eventP);

	public void insertCrowd(EventPVO eventP);
}
