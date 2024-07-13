package kr.spring.shop.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.member.vo.CouponVO;
import kr.spring.shop.vo.OrdersVO;
import kr.spring.shop.vo.PBasketVO;
import kr.spring.shop.vo.ProductVO;

public interface ShopService {
	public void registerProduct(ProductVO product);
	public List<ProductVO> productList(Map<String, Object> map);
	public Integer productCount(Map<String, Object> map);
	public Integer productAllCount(Map<String, Object> map);
	public ProductVO productDetail(Long p_num);
	
	public void ProductFav(ProductVO fav);
	public ProductVO selectProductFav(ProductVO fav);
	public void ProductFavDelete(ProductVO fav);
	public Integer productFavCount(Long p_num);
	public List<ProductVO> productFavList(Long mem_num);
	
	public Integer productRemain(Long p_num);
	
	public Integer productPut(Long pb_num);
	
	public PBasketVO selectProductBasket(PBasketVO basket);
	public void ProductBasket(PBasketVO basket);
	public void ProductBasketDelete(PBasketVO basket);
	public List<PBasketVO> productBasketList(Long mem_num);
	/* public List<Integer> basketPrice(Long mem_num); */
	public Integer basketTotalPrice(@Param(value="mem_num") Long mem_num, @Param(value="p_num") Long p_num);
	public Integer basketCount(@Param(value="mem_num") Long mem_num, @Param(value="p_num") Long p_num);
	public void basketDelete(long pb_num);
	
	// 바로 구매
	public void directOrder(OrdersVO orders);
	/* public Integer selectOrderNUM(long mem_num); */
	public void usePoint(OrdersVO orders);
	public void useCoupon(long mc_num);
	public void sellProduct(@Param(value="p_quantity") Long p_quantity, @Param(value="p_num") Long p_num);
	/* public void directOrderDetail(OrdersVO orders); */
	public Integer getPoint(long mem_num);
	long getNextOrderNum();
	
	// 쿠폰 조건
	public CouponVO couponInfo(long mc_num);
	
	// 관리자
	public List<ProductVO> adminProductList(Map<String, Object> map);
}
