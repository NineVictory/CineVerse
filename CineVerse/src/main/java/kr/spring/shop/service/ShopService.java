package kr.spring.shop.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.spring.member.vo.CouponVO;
import kr.spring.myPage.vo.MyPageVO;
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
	public PBasketVO selectBasket(long pb_num);
	public void basketUpdate(@Param(value="pb_num") Long pb_num, @Param(value="pb_quantity") Long pb_quantity);

	// 바로 구매
	public void directOrder(OrdersVO orders);
	/* public Integer selectOrderNUM(long mem_num); */
	public void usePoint(OrdersVO orders);
	public void useCoupon(@Param("mem_coupon_use") long mem_coupon_use, @Param("mc_num") long mc_num);
	public void sellProduct(@Param(value="p_quantity") Long p_quantity, @Param(value="p_num") Long p_num);
	public void directOrderDetail(OrdersVO orders);
	public Integer getPoint(long mem_num);
	long getNextOrderNum();

	// 쿠폰 조건
	public CouponVO couponInfo(long mc_num);

	// 관리자
	public List<ProductVO> adminProductList(Map<String, Object> map);

	List<PBasketVO> selectFromPBasket(@Param("pb_num") List<Integer> pb_num);


	// 마이페이지
	public List<OrdersVO> selectOrders(long mem_num);
	public int countOrders(long mem_num);
	public List<OrdersVO> howMuch(long mem_num);
	public List<OrdersVO> howManyQuantity(long mem_num);
	public OrdersVO selectOrderDetailOne(long mem_num);
	public List<OrdersVO> orderDetailList(long order_num);
	public Integer orderPrice(long order_num);
	public OrdersVO selectOrder(long order_num);

	public void orderConfirm(long order_num);
	public void writeProductReview(ProductVO product); 
	public Integer countReview(long order_num);
	public Long selectOrderNum(long od_num);
	public Integer countOrderDetail(long order_num);
	public void updateOrderReStatus(long order_num);
	public CouponVO usedCoupon(long order_num);
	
	public Float reviewGrade(long p_num);
	public List<ProductVO> reviewList(long p_num);
	public Integer reviewCount(long p_num);
	
	public List<ProductVO> recommandProduct(long p_category);
	public Integer productFavCnt(long mem_num);
	public ProductVO selectMostCategory(long mem_num);
	public List<MyPageVO> selectMemCouponList(Map<String, Object> map);	// 회원 쿠폰 목록 불러오기
	
	
	public void updateProduct(ProductVO productVO);
	public void deleteFile(Long p_num);
	public List<OrdersVO> orderList(Map<String, Object> map);
	public Integer orderCount(Map<String, Object> map);
	public List<OrdersVO> adminOrderDetailList(Long order_num);
	public OrdersVO adminOrders(Long order_num);
	public void updateOrderStatus(@Param(value="order_status") int orders_status, @Param(value="order_num") Long order_num);
	public OrdersVO selectOrderAddress(Long a_num);
	public List<OrdersVO> selectMemAddress(Long mem_num);
	public void updateOrderAddress(@Param(value="a_num") Long a_num, @Param(value="order_num") Long order_num);
	public List<ProductVO> selectReviewList(Map<String, Object> map);
	public Integer adminReviewCount(Map<String, Object> map);
	public void deleteReview(Long pr_num);
}
