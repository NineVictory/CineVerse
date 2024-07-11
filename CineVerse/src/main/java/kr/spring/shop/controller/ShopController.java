package kr.spring.shop.controller;

import java.net.http.HttpRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.shop.service.ShopService;
import kr.spring.shop.vo.ProductVO;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;


@Slf4j
@Controller
public class ShopController {
	
	@Autowired
	private ShopService shopService;
	
	@GetMapping("/shop/shopMain")
	public String shopMain(@RequestParam(defaultValue="1") int pageNum,
	                       @RequestParam(defaultValue="1") int shopOrder,
	                       String keyfield, String keyword, Model model, HttpServletRequest request) {
	    String pCategoryParam = request.getParameter("p_category");
	    Integer p_category = null;

	    if (pCategoryParam != null && !pCategoryParam.equals("all") && !pCategoryParam.isEmpty()) {
	        try {
	            p_category = Integer.parseInt(pCategoryParam);
	        } catch (NumberFormatException e) {
	            System.out.println("Invalid p_category value: " + pCategoryParam);
	        }
	    }

	    log.debug("<<벌스샵 메인>> - p_category: " + p_category);
	    log.debug("<<벌스샵 메인>> - shopOrder: " + shopOrder);

	    Map<String, Object> map = new HashMap<>();
	    map.put("p_category", p_category);
	    map.put("keyfield", keyfield);
	    map.put("keyword", keyword);

	    int count = shopService.productCount(map);

	    PagingUtil page = new PagingUtil(keyfield, keyword, pageNum, count, 16, 10, "shopMain", "&p_category=" + p_category + "&shopOrder=" + shopOrder);

	    List<ProductVO> productList = null;
	    if (count > 0) {
	        map.put("shopOrder", shopOrder);
	        map.put("start", page.getStartRow());
	        map.put("end", page.getEndRow());

	        productList = shopService.productList(map);
	    }

	    model.addAttribute("count", count);
	    model.addAttribute("productList", productList);
	    model.addAttribute("page", page.getPage());

	    return "shopMain";
	}

	
	@GetMapping("/shop/shopDetail")
	public ModelAndView shopDetail(long p_num) {
		log.debug("<<벌스샵 상세 - p_num>> ::: " + p_num);
		
		ProductVO product = shopService.productDetail(p_num);
		product.setP_name(StringUtil.useNoHTML(product.getP_name()));
		
		return new ModelAndView("shopDetail", "product", product);
	}
	
	@PostMapping("/shop/shopBuy")
	public String shopBuy() {
		return "shopBuy";
	}
	
	@GetMapping("/shop/shopBasket")
	public String shopBasket() {
		return "shopBasket";
	}
	
}
