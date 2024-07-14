package kr.spring.myPage.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.vo.MemberVO;
import kr.spring.myPage.service.MyPageService;
import kr.spring.myPage.vo.MyPageVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MyPageAjaxController {
    @Autowired
    MyPageService mypageService;
    
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
}

