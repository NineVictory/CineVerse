package kr.spring.event.service;

import java.util.List;
import java.util.Map;

import kr.spring.event.vo.UserEventVO;

public interface EventService {
	public Integer selectEventRowCount(Map<String,Object> map);
	
	public List<UserEventVO> selectEventList(Map<String,Object> map);
}
