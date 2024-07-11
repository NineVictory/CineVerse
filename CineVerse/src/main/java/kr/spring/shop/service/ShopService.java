package kr.spring.shop.service;

import java.util.List;
import java.util.Map;

import kr.spring.shop.vo.ProductVO;

public interface ShopService {
	public void registerProduct(ProductVO product);
	public List<ProductVO> productList(Map<String, Object> map);
	public Integer productCount(Map<String, Object> map);
	public ProductVO productDetail(Long p_num);
	public void ProductFav(ProductVO fav);
	public ProductVO selectProductFav(ProductVO fav);
	public void ProductFavDelete(ProductVO fav);
	public Integer productFavCount(Long p_num);
}
