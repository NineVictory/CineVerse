package kr.spring.assignment.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.assignment.service.AssignService;
import kr.spring.assignment.vo.AssignFavVO;
import kr.spring.assignment.vo.AssignVO;
import kr.spring.board.controller.BoardAjaxController;
import kr.spring.board.vo.BoardVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.FileUtil;
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
	
	//상태 변경
	@PostMapping("/assignboard/updateStatus")
	@ResponseBody
	public Map<String,Object> updateStatus(AssignVO assign, HttpSession session){
		log.debug("*****양도 상태 변경 시작*****");
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			mapJson.put("result", "logout");
		}else {
			assign.setMem_num(user.getMem_num());
			AssignVO db_assign = assignService.ab_selectBoard(assign.getAb_num());
			if(db_assign.getMem_num() != assign.getMem_num()) {
				mapJson.put("result", "wrongAccess");
			}else {			
				assignService.ab_updateStatus(assign);
				mapJson.put("result", "success");
			}
		}
		
		return mapJson;
	}
	
	/*================
	 * 업로드 이미지 삭제
	 *================*/
	//업로드 파일 삭제
	@PostMapping("/assignboard/deleteFile")
	@ResponseBody
	public Map<String,String> processFile(
			              long ab_num,
			              HttpSession session,
			              HttpServletRequest request){
		Map<String,String> mapJson = 
				      new HashMap<String,String>();
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "logout");
		}else {
			AssignVO db_assign = 
					assignService.ab_selectBoard(ab_num); 
			//로그인한 회원번호와 작성자 회원번호 일치 여부 체크
			if(user.getMem_num() != db_assign.getMem_num()) {
				//불일치
				mapJson.put("result", "wrongAccess");
			}else {
				//일치
				assignService.ab_deleteFile(ab_num);
				FileUtil.removeFile(request, db_assign.getAb_filename());
				
				mapJson.put("result", "success");
			}
		}
		
		return mapJson;
	}
}
