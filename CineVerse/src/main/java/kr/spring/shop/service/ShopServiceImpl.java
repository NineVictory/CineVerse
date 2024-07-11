package kr.spring.shop.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.shop.dao.ShopMapper;
import kr.spring.shop.vo.ProductVO;

@Service
@Transactional
public class ShopServiceImpl implements ShopService {
	@Autowired
	ShopMapper shopMapper;
	
	@Override
	public void registerProduct(ProductVO product) {
		shopMapper.registerProduct(product);
	}

	@Override
	public List<ProductVO> productList(Map<String, Object> map) {
		return shopMapper.productList(map);
	}

	@Override
	public Integer productCount(Map<String, Object> map) {
		return shopMapper.productCount(map);
	}

	@Override
	public ProductVO productDetail(Long p_num) {
		return shopMapper.productDetail(p_num);
	}

	@Override
	public void ProductFav(ProductVO product) {
		shopMapper.ProductFav(product);
		
	}

	@Override
	public ProductVO selectProductFav(ProductVO fav) {
		return shopMapper.selectProductFav(fav);
	}

	@Override
	public void ProductFavDelete(ProductVO fav) {
		shopMapper.ProductFavDelete(fav);
	}

	@Override
	public Integer productFavCount(Long p_num) {
		return shopMapper.productFavCount(p_num);
	}

	@Override
	public ProductVO selectProductBasket(Long mem_num) {
		return shopMapper.selectProductBasket(mem_num);
	}

	@Override
	public void ProductBasket(ProductVO fav) {
		shopMapper.ProductBasket(fav);
	}

	@Override
	public void ProductBasketDelete(ProductVO fav) {
		shopMapper.ProductBasketDelete(fav);
	}

	@Override
	public List<ProductVO> productBasketList(Long mem_num) {
		return shopMapper.productBasketList(mem_num);
	}
	
	

}
