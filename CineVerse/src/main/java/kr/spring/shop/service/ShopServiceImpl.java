package kr.spring.shop.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.shop.dao.ShopMapper;
import kr.spring.shop.vo.PBasketVO;
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
	public PBasketVO selectProductBasket(PBasketVO basket) {
		return shopMapper.selectProductBasket(basket);
	}

	@Override
	public void ProductBasket(PBasketVO basket) {
		shopMapper.ProductBasket(basket);
	}

	@Override
	public void ProductBasketDelete(PBasketVO basket) {
		shopMapper.ProductBasketDelete(basket);
	}

	@Override
	public List<ProductVO> productBasketList(Long mem_num) {
		return shopMapper.productBasketList(mem_num);
	}

	@Override
	public Integer basketCount(Long mem_num) {
		return shopMapper.basketCount(mem_num);
	}
	/*
	 * @Override public List<Integer> basketPrice(Long mem_num) { return
	 * shopMapper.basketPrice(mem_num); }
	 */

	@Override
	public Integer basketTotalPrice(Long mem_num) {
		return shopMapper.basketTotalPrice(mem_num);
	}

	@Override
	public List<ProductVO> productFavList(Long mem_num) {
		return shopMapper.productFavList(mem_num);
	}
	
	

}
