package kr.spring.event.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.board.controller.BoardAjaxController;
import kr.spring.event.service.EventService;
import kr.spring.event.vo.EventPVO;
import kr.spring.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class EventAjaxController {
	@Autowired
	private EventService eventService;
	
	
	/*===================
	 * 이벤트 참여여부 읽어오기
	 *===================*/
	@GetMapping("/event/getParticipation")
	@ResponseBody
	public Map<String,Object> getParticipation(EventPVO eventP, HttpSession session){
		
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			mapJson.put("status", "noP");
		}else {
			//로그인된 회원번호 셋팅
			eventP.setMem_num(user.getMem_num());
			EventPVO db_eventP = eventService.selectParticipation(eventP);
			
			if(db_eventP != null) {
				mapJson.put("status", "yesP");
				
			}else {
				mapJson.put("status", "noP");
			}
			log.debug("이벤트참여여부 db_eventP********* " + db_eventP);
		}
		return mapJson;
	}
	
	//이벤트 참여하기
	@PostMapping("event/writeParticipation")
	@ResponseBody
	public Map<String,Object> writeParticipation(EventPVO eventP, HttpSession session){
		
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			mapJson.put("result", "logout");
		}else {
			//로그인된 회원번호 셋팅
			eventP.setMem_num(user.getMem_num());
			
			//EventPVO db_eventP = eventService.selectParticipation(eventP);
			
			eventService.insertParticipation(eventP);
			mapJson.put("status", "yesP");
			
			
			mapJson.put("result", "success");
		}
		log.debug("<<이벤트 참여 EventPVO**********" + eventP);
		return mapJson;
	}
}
