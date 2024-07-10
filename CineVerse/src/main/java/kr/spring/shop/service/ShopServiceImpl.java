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

}
