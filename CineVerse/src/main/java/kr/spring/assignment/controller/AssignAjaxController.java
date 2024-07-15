package kr.spring.assignment.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.assignment.service.AssignService;
import kr.spring.assignment.vo.AssignFavVO;
import kr.spring.board.controller.BoardAjaxController;

import kr.spring.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AssignAjaxController {
	@Autowired
	private AssignService assignService;
	
	
	/*===================
	 * 양도글 찜
	 *===================*/
	//양도글 찜 읽기
	@GetMapping("/assignboard/getFav")
	@ResponseBody
	public Map<String,Object> getFav(AssignFavVO fav, HttpSession session){
		log.debug("<<양도글 찜 - AssignFavVO>> : " + fav);
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			mapJson.put("status", "noFav");
		}else {
			//로그인된 회원번호 셋팅
			fav.setMem_num(user.getMem_num());
			AssignFavVO assignFav = assignService.ab_selectFav(fav);
			
			if(assignFav != null) {
				mapJson.put("status", "yesFav");
			}else {
				mapJson.put("status", "noFav");
			}
		}
		mapJson.put("count", assignService.ab_selectFavCount(fav.getAb_num()));

		return mapJson;
	}
	
	//양도글 찜 등록/삭제
	@PostMapping("/assignboard/writeFav")
	@ResponseBody
	public Map<String,Object> writeFav(AssignFavVO fav, HttpSession session){
		log.debug("<<양도글 찜 - 등록>> : " + fav);
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			mapJson.put("result", "logout");
		}else {
			//로그인된 회원번호 셋팅
			fav.setMem_num(user.getMem_num());
			
			AssignFavVO assignFav = assignService.ab_selectFav(fav);
			if(assignFav != null) {
				//등록 -> 삭제
				assignService.ab_deleteFav(fav);
				mapJson.put("status", "noFav");
			}else {
				//등록
				assignService.ab_insertFav(fav);
				mapJson.put("status", "yesFav");
			}
			mapJson.put("result", "success");
			mapJson.put("count", assignService.ab_selectFavCount(fav.getAb_num()));
		}
		return mapJson;
	}
}
