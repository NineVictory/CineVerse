package kr.spring.shop.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.member.vo.CouponVO;
import kr.spring.shop.dao.ShopMapper;
import kr.spring.shop.vo.OrdersVO;
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
	public List<PBasketVO> productBasketList(Long mem_num) {
		return shopMapper.productBasketList(mem_num);
	}

	/*
	 * @Override public List<Integer> basketPrice(Long mem_num) { return
	 * shopMapper.basketPrice(mem_num); }
	 */

	

	@Override
	public List<ProductVO> productFavList(Long mem_num) {
		return shopMapper.productFavList(mem_num);
	}

	@Override
	public List<ProductVO> adminProductList(Map<String, Object> map) {
		return shopMapper.adminProductList(map);
	}

	@Override
	public Integer productAllCount(Map<String, Object> map) {
		return shopMapper.productAllCount(map);
	}

	@Override
	public Integer productRemain(Long p_num) {
		return shopMapper.productRemain(p_num);
	}

	@Override
	public Integer productPut(Long pb_num) {
		return shopMapper.productPut(pb_num);
	}

	@Override
	public Integer basketTotalPrice(Long mem_num, Long p_num) {
		return shopMapper.basketTotalPrice(mem_num, p_num);
	}

	@Override
	public Integer basketCount(Long mem_num, Long p_num) {
		return shopMapper.basketCount(mem_num, p_num);
	}

	@Override
	public void directOrder(OrdersVO orders) {
		/*
		 * long order_num = shopMapper.getNextOrderNum();
		 * orders.setOrder_num(order_num);
		 */
		shopMapper.directOrder(orders);
		shopMapper.directOrderDetail(orders);
		
	}

	@Override
	public void usePoint(OrdersVO orders) {
		shopMapper.usePoint(orders);
		
	}

	@Override
	public void useCoupon(long mc_num) {
		shopMapper.useCoupon(mc_num);
	}

	@Override
	public void sellProduct(Long p_quantity, Long p_num) {
		shopMapper.sellProduct(p_quantity, p_num);
		
	}

	/*
	 * @Override public void directOrderDetail(OrdersVO orders) {
	 * shopMapper.directOrderDetail(orders); }
	 */
	@Override
	public Integer getPoint(long mem_num) {
		return shopMapper.getPoint(mem_num);
	}
	/*
	 * @Override public Integer selectOrderNUM(long mem_num) { return
	 * shopMapper.selectOrderNUM(mem_num);
	 * 
	 * }
	 */

	@Override
	public CouponVO couponInfo(long mc_num) {
		return shopMapper.couponInfo(mc_num);
	}

	@Override
	public void basketDelete(long pb_num) {
		shopMapper.basketDelete(pb_num);
	}

	@Override
	public long getNextOrderNum() {
		return shopMapper.getNextOrderNum();
	}

	@Override
	public PBasketVO selectBasket(long pb_num) {
		return shopMapper.selectBasket(pb_num);
	}

	@Override
	public void basketUpdate(Long pb_num, Long pb_quantity) {
		shopMapper.basketUpdate(pb_num, pb_quantity);
	}
	
	

}
