package kr.spring.myPage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.vo.MemberVO;
import kr.spring.myPage.service.MyPageService;
import kr.spring.myPage.service.MyPageService2;
import kr.spring.myPage.vo.AddressVO;
import kr.spring.myPage.vo.MyPageVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MyPageAjaxController {
	@Autowired
	MyPageService mypageService;

	@Autowired
	MyPageService2 mypageService2;
	
	@PostMapping("/myPage/updateMyPhoto")
	@ResponseBody
	public Map<String, String> processProfile(MyPageVO myPageVO, HttpSession session) {
		Map<String, String> mapAjax = new HashMap<>();
		MemberVO user = (MemberVO) session.getAttribute("user");
		if (user == null) {
			mapAjax.put("result", "logout");
		} else {
			myPageVO.setMem_num(user.getMem_num());
			mypageService.updateProfile(myPageVO);

			// 세션에 업데이트된 프로필 사진 저장
			user.setPhoto(myPageVO.getPhoto());
			user.setPhoto_name(myPageVO.getPhoto_name());
			session.setAttribute("user", user);

			log.debug("<< 프로필 사진 업데이트 성공 >> : " + user.getPhoto_name());

			mapAjax.put("result", "success");
		}

		return mapAjax;
	}

	
	//배송지 삭제
	@PostMapping("/myPage/deleteAddress")
	@ResponseBody
	public Map<String, Object> deleteAddress(long a_num, HttpSession session) {
	    log.debug("<<배송지 삭제 - a_num>> : " + a_num);
	    Map<String, Object> mapJson = new HashMap<String, Object>();
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    AddressVO address = mypageService2.selectOrder(a_num);
	    if (user == null) {
	        mapJson.put("result", "logout");
	    } else if(address != null){
	    	mypageService2.updateAddressStatus(a_num);
	    	mapJson.put("result", "success");
	    } else {
	    	mypageService2.deleteAddress(a_num);
	    	mapJson.put("result", "success");
	    }
	    
	    return mapJson;
	}

	
	
}
