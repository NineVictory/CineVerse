package kr.spring.shop.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.shop.vo.ProductVO;

@Mapper
public interface ShopMapper {
	// 관리자 - 상품 등록
	public void registerProduct(ProductVO product);
	
	// 이용자
	// 상품
	// 상품 목록
	public List<ProductVO> productList(Map<String, Object> map);
	// 상품 카운트
	public Integer productCount(Map<String, Object> map);
	// 상품 상세
	@Select("SELECT * FROM product WHERE p_num=#{p_num}")
	public ProductVO productDetail(Long p_num);
	
	// 찜 여부 구하기
	@Select("SELECT * FROM product_fav WHERE p_num=#{p_num} AND mem_num=#{mem_num}")
	public ProductVO selectProductFav(ProductVO fav);
	// 상품 찜하기
	@Insert("INSERT INTO product_fav (p_num, mem_num) VALUES (#{p_num}, #{mem_num})")
	public void ProductFav(ProductVO fav);
	// 상품 찜 취소하기
	@Delete("DELETE FROM product_fav WHERE p_num=#{p_num} AND mem_num=#{mem_num}")
	public void ProductFavDelete(ProductVO fav);
	// 상품 찜 전체 개수
	@Select("SELECT COUNT(*) FROM product_fav WHERE p_num=#{p_num}")
	public Integer productFavCount(Long p_num);
	
}
