package kr.spring.shop.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.member.vo.CouponVO;
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
	
	// 장바구니 삭제 
	@Delete("DELETE p_basket WHERE pb_num=#{pb_num}")
	public void basketDelete(long pb_num);
	
	// 개별 장바구니
	@Select("SELECT * FROM p_basket WHERE pb_num=#{pb_num}")
	public PBasketVO selectBasket(long pb_num);
	
	// 장바구니 수량 변경
	@Update("UPDATE p_basket SET pb_quantity=#{pb_quantity} WHERE pb_num=#{pb_num}")
	public void basketUpdate(@Param(value="pb_num") Long pb_num, @Param(value="pb_quantity") Long pb_quantity);
	
	// 주문
	public void productOrders(OrdersVO orders);
	
	
	// 상품 결제
	@Insert("INSERT INTO ORDERS (order_num, mem_num, a_num, od_number) VALUES (#{order_num}, #{mem_num}, #{a_num}, #{od_number})")
    void directOrder(OrdersVO orders);
	// 상품 결제 내역
    @Insert("INSERT INTO ORDER_DETAIL (od_num, order_quantity, order_num, p_num) VALUES (order_detail_seq.nextval, #{order_quantity}, #{order_num}, #{p_num})")
    void directOrderDetail(OrdersVO orders);
    // 상품 번호 생성
    @Select("SELECT orders_seq.nextval FROM dual")
    long getNextOrderNum();
    
	// 상품 수량 차감하기
	@Update("UPDATE product SET p_quantity = p_quantity - #{p_quantity} WHERE p_num = #{p_num}")
	public void sellProduct(@Param(value="p_quantity") Long p_quantity, @Param(value="p_num") Long p_num);

	// 유저 보유 포인트 불러오기
	@Select("SELECT point FROM member_detail WHERE mem_num=#{mem_num}")
	public Integer getPoint(long mem_num);
	
	// 포인트 차감하기
	@Insert("INSERT INTO point_history (ph_num, ph_point, mem_num, ph_type, ph_payment) VALUES (point_history_seq.nextval, #{ph_point}, #{mem_num}, 1, 'goods')")
	public void usePoint(OrdersVO orders);
	
	// 쿠폰 사용하기
	@Update("UPDATE member_coupon SET coupon_use=2, mem_coupon_use=#{mem_coupon_use} WHERE mc_num=#{mc_num}")
	public void useCoupon(@Param("mem_coupon_use") long mem_coupon_use, @Param("mc_num") long mc_num);
	
	// 쿠폰 조건 체크
	@Select("SELECT * FROM member_coupon JOIN coupon_db USING(coupon_num) WHERE mc_num=#{mc_num}")
	public CouponVO couponInfo(long mc_num);
	
	// 관리자 - 벌스샵
	public List<ProductVO> adminProductList(Map<String, Object> map);
	
	// 장바구니에서 선택한 상품 불러오기
	public List<PBasketVO> selectFromPBasket(@Param("pb_num") List<Integer> pb_num);
	
	// 주문 목록과 대표 상품명, 이미지 가져오기
	public List<OrdersVO> selectOrders(long mem_num);
	
	// 구매 1건 불러오기
	@Select("SELECT * FROM orders WHERE order_num=#{order_num}")
	public OrdersVO selectOrder(long order_num);
	
	// 그 개수
	@Select("SELECT COUNT(*) FROM orders WHERE mem_num = #{mem_num}")
	int countOrders(long mem_num);
	
	// 구매 건의 총 비용
	public List<OrdersVO> howMuch(long mem_num);
	
	// 구매 건의 총 개수
	public List<OrdersVO> howManyQuantity(long mem_num);
	
	// 구매 번호로 한 건만 내역 읽어오기 (대표)
	@Select("SELECT * FROM order_detail od JOIN product p ON od.p_num = p.p_num JOIN orders o ON od.order_num = o.order_num WHERE mem_num = #{mem_num} AND ROWNUM = 1")
	public OrdersVO selectOrderDetailOne(long mem_num);
	 
	// 구매 번호로 구매 내역 리스트 불러오기 
	@Select("SELECT * FROM order_detail od JOIN orders o ON od.order_num = o.order_num JOIN product p ON od.p_num = p.p_num WHERE od.order_num = #{order_num}")
	public List<OrdersVO> orderDetailList(long order_num);
	
	// 구매 번호로 구매 총 비용 불러오기
	@Select("SELECT SUM(od.order_quantity * p.p_price) FROM order_detail od JOIN product p ON od.p_num = p.p_num WHERE od.order_num = #{order_num}")
	Integer orderPrice(long order_num);
	
	
	// 주문 확정하기 (사용자)
	@Update("UPDATE orders SET order_status=6 WHERE order_num=#{order_num}")
	public void orderConfirm(long order_num);
	
	// 리뷰 쓰기
	@Insert("INSERT INTO product_review (pr_num, pr_content, pr_reg_date, od_num, p_num, pr_grade) " +
	        "VALUES (product_review_seq.nextval, #{pr_content}, SYSDATE, #{od_num}, #{p_num}, #{pr_grade})")
	public void writeProductReview(ProductVO product);
	
	// 리뷰 상태 업데이트
	@Update("UPDATE order_detail SET od_review_status=2 WHERE od_num=#{od_num}")
	public void updateReviewStatus(long od_num);
	
	// 리뷰 카운트
	@Select("SELECT Count(*) FROM order_detail WHERE od_review_status=2 AND order_num=#{order_num}")
	public Integer countReview(long order_num);
	
	// od_num으로 order_num구하기
	@Select("SELECT order_num FROM order_detail WHERE od_num=#{od_num}")
	public Long selectOrderNum(long od_num);
	
	// order_num으로 order_detail 개수 구하기
	@Select("SELECT count(*) FROM order_detail WHERE order_num=#{order_num}")
	public Integer countOrderDetail(long order_num);
	
	// orders 테이블의 order_re_status 업데이트
	@Update("UPDATE orders SET order_re_status=2 WHERE order_num=#{order_num}")
	public void updateOrderReStatus(long order_num);
	
	// 사용한 쿠폰 있는지 찾아보기
	@Select("SELECT * FROM member_coupon JOIN coupon_db USING(coupon_num) WHERE mem_coupon_use=#{mem_coupon_use}")
	public CouponVO usedCoupon(long order_num);
	
	// 리뷰 평점 
	@Select("SELECT AVG(pr_grade) FROM product_review WHERE p_num = #{p_num} GROUP BY p_num")
	public Float reviewGrade(long p_num);
	
	// 리뷰 리스트
	@Select("SELECT * FROM product_review JOIN order_detail USING(od_num) JOIN orders USING(order_num) JOIN member USING(mem_num) WHERE product_review.p_num=#{p_num}")
	public List<ProductVO> reviewList(long p_num);
	
	// 리뷰 카운트
	@Select("select count(*) from product_review WHERE p_num=#{p_num}")
	public Integer reviewCount(long p_num);
}
