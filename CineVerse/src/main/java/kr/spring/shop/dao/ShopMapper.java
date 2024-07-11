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
	
	// 관심 상품 여부 구하기
	@Select("SELECT * FROM product_fav WHERE p_num=#{p_num} AND mem_num=#{mem_num}")
	public ProductVO selectProductFav(ProductVO fav);
	// 관심 상품 하기
	@Insert("INSERT INTO product_fav (p_num, mem_num) VALUES (#{p_num}, #{mem_num})")
	public void ProductFav(ProductVO fav);
	// 관심 상품 취소하기
	@Delete("DELETE FROM product_fav WHERE p_num=#{p_num} AND mem_num=#{mem_num}")
	public void ProductFavDelete(ProductVO fav);
	// 관심 상품 전체 개수
	@Select("SELECT COUNT(*) FROM product_fav WHERE p_num=#{p_num}")
	public Integer productFavCount(Long p_num);
	
	// 상품 장바구니 여부
	@Select("SELECT p_num FROM p_basket WHERE mem_num=#{mem_num}")
	public ProductVO selectProductBasket(ProductVO fav);
	// 상품 장바구니 넣기
	@Insert("INSERT INTO p_basket (pb_num, pb_quantity, p_reg_date, p_num, mem_num) VALUES (p_basket_seq.nextval, #{pb_quantity}, SYSDATE, #{p_num}, #{mem_num})")
	public void ProductBasket(ProductVO fav);
	// 상품 장바구니 빼기
	@Delete("DELETE FROM p_basket WHERE pb_num=#{pb_num}")
	public void ProductBasketDelete(ProductVO fav);
	// 내 장바구니 리스트 구하기
	@Select("SELECT FROM p_basket WHERE mem_num=#{mem_num}")
	public List<ProductVO> productBasketList(Long mem_num);
}
