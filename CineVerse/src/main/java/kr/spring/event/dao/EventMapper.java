package kr.spring.event.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.event.vo.UserEventVO;


@Mapper
public interface EventMapper {
	@Select("SELECT COUNT(*) FROM event")
	public Integer selectEventRowCount(Map<String,Object> map);
	
	public List<UserEventVO> selectEventList(Map<String,Object> map);
}
