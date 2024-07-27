package kr.spring.event.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.event.service.EventService;
import kr.spring.event.vo.EventPVO;
import kr.spring.event.vo.UserEventVO;
import kr.spring.member.vo.MemberVO;
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
		PagingUtil page = new PagingUtil(keyfield,keyword,pageNum,count,10,10,"event","&event_type="+event_type);
		List<UserEventVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = eventService.selectEventList(map);
			
			// DateTimeFormatter를 설정합니다.
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            
            for (UserEventVO event : list) {
                // DB에서 불러온 날짜를 가져옵니다.
                String targetDateString = event.getEvent_end();
                
                // DateTimeFormatter를 사용하여 문자열을 LocalDate로 변환합니다.
                LocalDate targetDate = LocalDate.parse(targetDateString, formatter);
                
                // 오늘 날짜를 가져옵니다.
                LocalDate today = LocalDate.now();
                
                // 남은 일수를 계산합니다.
                long daysUntilTarget = ChronoUnit.DAYS.between(today, targetDate);
                
                event.setT_rest(daysUntilTarget);
                // 필요하다면 UserEventVO 객체에 D-Day를 저장하는 필드를 추가하고 값을 설정할 수 있습니다.
                // event.setDaysUntilTarget(daysUntilTarget); // D-Day 저장
            }
		}
		
		
		model.addAttribute("count", count); log.debug("count**********" + count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
		
	
		return "eventMain";
	}
	
	
	/*====================
	 *이벤트 상세
	 =====================*/
	@GetMapping("/event/eventDetail")
	public ModelAndView process(long event_num) {
		log.debug("이벤트 상세 - event_num**************" + event_num);
		
		UserEventVO eventVO = eventService.selectEvent(event_num);
		
		//제목에 태그를 허용하지 않음
		eventVO.setEvent_name(StringUtil.useNoHTML(eventVO.getEvent_name()));
		
		//내용에 태그를 허용하지 않으면서 줄바꿈 처리(CKEditor 사용시 주석 처리)
		//board.setContent(StringUtil.useBrNoHTML(board.getContent()));
		ModelAndView modelAndView = new ModelAndView("eventDetail");
		modelAndView.addObject("event", eventVO);
		return modelAndView;
	}
	
	
	
	@GetMapping("/event/end")
	public String eventEnd(@RequestParam(defaultValue="1") int pageNum,
			  				@RequestParam(defaultValue="1") int order, 
							String keyfield, String keyword, Model model) {

		log.debug("*** 종료된이벤트 목록 ***");
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		//전체, 검색 레코드수
		int count = eventService.selectEndedEventRowCount(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,pageNum,count,10,10,"end");
		List<UserEventVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = eventService.selectEndedEventList(map);
			
			
		}
		
		model.addAttribute("count", count); log.debug("*** count ***" + count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
		
		return "eventEnd";
	}
}
