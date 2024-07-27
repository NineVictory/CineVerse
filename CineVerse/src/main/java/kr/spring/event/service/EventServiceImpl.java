package kr.spring.event.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.event.dao.EventMapper;
import kr.spring.event.vo.EventPVO;
import kr.spring.event.vo.UserEventVO;

@Service
@Transactional
public class EventServiceImpl implements EventService{

	@Autowired
	EventMapper eventMapper;
	
	@Override
	public Integer selectEventRowCount(Map<String, Object> map) {
		return eventMapper.selectEventRowCount(map);
	}

	@Override
	public List<UserEventVO> selectEventList(Map<String, Object> map) {
		return eventMapper.selectEventList(map);
	}

	@Override
	public UserEventVO selectEvent(long event_num) {
		return eventMapper.selectEvent(event_num);
	}

	@Override
	public EventPVO selectParticipation(EventPVO eventP) {
		return eventMapper.selectParticipation(eventP);
	}

	@Override
	public void insertParticipation(EventPVO eventP) {
		eventMapper.insertParticipation(eventP);
	}

	@Override
	public void insertCrowd(EventPVO eventP) {
		eventMapper.insertCrowd(eventP);
	}

}
