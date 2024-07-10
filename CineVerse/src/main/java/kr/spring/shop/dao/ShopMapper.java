package kr.spring.shop.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.shop.vo.ProductVO;

@Mapper
public interface ShopMapper {
	// 상품 등록
	public void registerProduct(ProductVO product);
}
