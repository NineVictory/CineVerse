package kr.spring.shop.service;

import java.util.List;
import java.util.Map;

import kr.spring.shop.vo.ProductVO;

public interface ShopService {
	public void registerProduct(ProductVO product);
	public List<ProductVO> productList(Map<String, Object> map);
	public Integer productCount(Map<String, Object> map);
}
