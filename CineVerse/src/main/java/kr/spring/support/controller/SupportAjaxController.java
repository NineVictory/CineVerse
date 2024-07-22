package kr.spring.support.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.support.service.SupportService;
import kr.spring.support.vo.ConsultVO;
import kr.spring.util.PagingUtil;

@Controller
public class SupportAjaxController {
	@Autowired
	private SupportService supportService;
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/support/consults")
    @ResponseBody
    public String getNews(@RequestParam(value = "myPosts", required = false) String myPostsParam,
    					  @RequestParam(defaultValue="1") int pageNum,
    					  HttpServletRequest request, HttpSession session,
                          Model model) {

        // Get the logged-in user
        MemberVO user = (MemberVO)session.getAttribute("user");
        boolean myPosts = "true".equals(myPostsParam);
        List<ConsultVO> list = null;
        int count = 0;
        if (myPosts && user != null) {
            MemberVO member = memberService.selectCheckMember(user.getMem_id());
    		model.addAttribute("member", member);

            
            Map<String,Object> map = new HashMap<String,Object>();
            map.put("mem_num", member.getMem_num());
            count = supportService.selectConsultRowCount(map);
    		
    		//페이지 처리
    		PagingUtil page = new PagingUtil(null,null,pageNum,count,15,10,"consultList","&mem_num="+member.getMem_num());

    		if(count > 0) {
    			map.put("start", page.getStartRow());
    			map.put("end", page.getEndRow());
    			
    			list = supportService.selectConsultList(map);
    		}
    		model.addAttribute("page", page.getPage());
        } else {
    		Map<String,Object> map = new HashMap<String,Object>();

    		count = supportService.selectConsultRowCount(map);
    		
    		//페이지 처리
    		PagingUtil page = new PagingUtil(null,null,pageNum,count,15,10,"consultList");
    		if(count > 0) {
    			map.put("start", page.getStartRow());
    			map.put("end", page.getEndRow());
    			
    			list = supportService.selectConsultList(map);
    		}
    		model.addAttribute("page", page.getPage());
        }

        model.addAttribute("list", list);
        model.addAttribute("count", count); // Set the count for conditionals
         // Assuming you have a method for pagination

        // Return a fragment of the JSP
        return "fragments/posts"; // This will be resolved by a view resolver to the appropriate JSP fragment
    }
}
