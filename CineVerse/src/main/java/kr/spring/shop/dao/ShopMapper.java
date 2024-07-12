package kr.spring.shop.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.shop.vo.OrdersVO;
import kr.spring.shop.vo.PBasketVO;
import kr.spring.shop.vo.ProductVO;

@Mapper
public interface ShopMapper {
	// 관리자 - 상품 등록
	public void registerProduct(ProductVO product);
	
	// 이용자
	// 상품
	// 상품 목록
	public List<ProductVO> productList(Map<String, Object> map);
	// 상품 카운트 - 표시 상품
	public Integer productCount(Map<String, Object> map);
	// 상품 카운트 - 전체 상품
	public Integer productAllCount(Map<String, Object> map);
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
	// 내 관심 상품 리스트 구하기
	@Select("SELECT * FROM product_fav JOIN product USING(p_num) WHERE mem_num=#{mem_num}")
	public List<ProductVO> productFavList(Long mem_num);
	
	// 상품 수량 불러오기 - 단품
	@Select("SELECT p_quantity FROM product WHERE p_num=#{p_num}")
	public Integer productRemain(Long p_num);
	
	// 장바구니에 담은 수량 불러오기
	@Select("SELECT pb_quantity FROM p_basket WHERE pb_num=#{pb_num}")
	public Integer productPut(Long pb_num);
	
	// 상품 장바구니 여부
	@Select("SELECT * FROM p_basket WHERE mem_num=#{mem_num} AND p_num=#{p_num}")
	public PBasketVO selectProductBasket(PBasketVO basket);
	// 상품 장바구니 넣기
	@Insert("INSERT INTO p_basket (pb_num, pb_quantity, pb_reg_date, p_num, mem_num) VALUES (p_basket_seq.nextval, #{pb_quantity}, SYSDATE, #{p_num}, #{mem_num})")
	public void ProductBasket(PBasketVO basket);
	// 상품 장바구니 빼기
	@Delete("DELETE FROM p_basket WHERE pb_num=#{pb_num}")
	public void ProductBasketDelete(PBasketVO basket);
	// 내 장바구니 리스트 구하기
	@Select("SELECT * FROM p_basket JOIN product USING(p_num) WHERE mem_num=#{mem_num}")
	public List<PBasketVO> productBasketList(Long mem_num);
	/*
	 * // 장바구니 각각 가격
	 * @Select("SELECT p_price * pb_quantity FROM p_basket JOIN product USING(p_num) WHERE mem_num = #{mem_num}"
	 * ) public List<Integer> basketPrice(Long mem_num);
	 */
	
	// 장바구니 총 가격 - 재고 있는 것만
	@Select("SELECT (p_price * pb_quantity) FROM p_basket JOIN product USING(p_num) WHERE mem_num = #{mem_num} AND p_num=#{p_num}")
	public Integer basketTotalPrice(@Param(value="mem_num") Long mem_num, @Param(value="p_num") Long p_num);
	
	// 장바구니 총 개수
	@Select("SELECT pb_quantity FROM p_basket WHERE mem_num = #{mem_num} AND p_num=#{p_num}")
	public Integer basketCount(@Param(value="mem_num") Long mem_num, @Param(value="p_num") Long p_num);
	
	// 주문
	public void productOrders(OrdersVO orders);
	
	
	
	// 바로 구매하기 -> 결제
	@Insert("INSERT INTO ORDERS (order_num, mem_num) VALUES (orders_seq.nextval, #{mem_num})")
	public void directOrder(OrdersVO orders);
	
	// 바로 구매하기 -> 결제 내역
	@Insert("INSERT INTO ORDER_DETAIL (od_num, order_quantity, order_num, p_num) VALUES (order_detail_seq.nextval, #{order_quantity}, #{order_num}, #{p_num})")
	public void directOrderDetail(OrdersVO orders);
	
	// 상품 수량 차감하기
	@Update("UPDATE product SET p_quantity = p_quantity - #{p_quantity} WHERE p_num = #{p_num}")
	public void sellProduct(@Param(value="p_quantity") Long p_quantity, @Param(value="p_num") Long p_num);
	
	// 포인트 차감하기
	@Insert("INSERT INTO point_history (ph_num, ph_point, mem_num, ph_type) VALUES (point_history_seq.nextval, #{ph_point}, #{mem_num}, 1)")
	public void usePoint(OrdersVO orders);
	
	// 쿠폰 사용하기
	@Delete("DELETE FROM member_coupon WHERE mc_num=#{mc_num}")
	public void useCoupon(long mc_num);
	
	
	
	// 관리자 - 벌스샵
	public List<ProductVO> adminProductList(Map<String, Object> map);
	
	
	
}
