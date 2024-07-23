package kr.spring.admin.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.vo.MemberVO;
import kr.spring.shop.service.ShopService;
import kr.spring.shop.vo.ProductVO;
import kr.spring.util.FileUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AdminAjaxController {
    
    @Autowired
    private ShopService shopService;
    
    // 업로드 파일 삭제
    @PostMapping("/admin/deleteFile")
    @ResponseBody
    public Map<String, String> processFile(long p_num, HttpSession session, HttpServletRequest request) {
        Map<String, String> mapJson = new HashMap<String, String>();
        MemberVO user = (MemberVO) session.getAttribute("user");
        
        if (user == null) {
            mapJson.put("result", "logout");
        } else if (user.getMem_auth() != 9) {
            mapJson.put("result", "noAdmin");
        } else {
            ProductVO db_product = shopService.productDetail(p_num);
            
            shopService.deleteFile(p_num);
            FileUtil.removeFile(request, db_product.getP_filename());
            
            mapJson.put("result", "success");
        }
        
        return mapJson;
    }
    
    // 리뷰 삭제
    @PostMapping("/admin/deleteReview")
    @ResponseBody
	public Map<String, String> deleteReview(@RequestParam Long pr_num, Model model, HttpServletRequest request, HttpSession session) {
    	 Map<String, String> mapJson = new HashMap<String, String>();
         MemberVO user = (MemberVO) session.getAttribute("user");
         
         if (user == null) {
             mapJson.put("result", "logout");
         } else if (user.getMem_auth() != 9) {
             mapJson.put("result", "noAdmin");
         } else {
        	 shopService.deleteReview(pr_num);     
             mapJson.put("result", "success");
         }
         
         return mapJson;
		
		
	}
}
