package kr.spring.event.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.event.service.EventService;
import kr.spring.event.vo.UserEventVO;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class EventController {
	
	@Autowired
	EventService eventService;
	
	//자바빈(VO) 초기화
	@ModelAttribute
	public UserEventVO initCommand() {
		return new UserEventVO();
	}
	
	@GetMapping("/event/event")
	public String eventMain(@RequestParam(defaultValue="1") int pageNum,
			  				@RequestParam(defaultValue="1") int order,
							@RequestParam(defaultValue="") String event_type, 
							String keyfield, String keyword, Model model) {

		log.debug("이벤트목록 - event_type***************" + event_type);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("event_type", event_type);
		
		//전체, 검색 레코드수
		int count = eventService.selectEventRowCount(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,pageNum,count,10,10,"list","&event_type="+event_type);
		List<UserEventVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = eventService.selectEventList(map);
			
		}
		
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
		
	
		return "eventMain";
	}
	
	
	/*====================
	 *이벤트 상세
	 =====================*/
	@GetMapping("/event/eventDetail")
	public ModelAndView process(long event_num) {
		log.debug("이벤트 상세 - cb_num**************" + event_num);
		
		UserEventVO eventVO = eventService.selectEvent(event_num);
		
		//제목에 태그를 허용하지 않음
		eventVO.setEvent_name(StringUtil.useNoHTML(eventVO.getEvent_name()));
		
		//내용에 태그를 허용하지 않으면서 줄바꿈 처리(CKEditor 사용시 주석 처리)
		//board.setContent(StringUtil.useBrNoHTML(board.getContent()));
		ModelAndView modelAndView = new ModelAndView("eventDetail");
		modelAndView.addObject("event", eventVO);
		return modelAndView;
	}
}
