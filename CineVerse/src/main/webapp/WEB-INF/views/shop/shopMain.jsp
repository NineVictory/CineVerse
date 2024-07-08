<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- 벌스샵 시작 -->
<div class="shop-page">
	<div class="shop-main">
		<form action="shopSearch" id="shop_search">
			<ul>
			<li>
				<input type="search" name="search" placeholder="검색어를 입력하세요">
				<input type="submit" value="" style="background-image: url('${pageContext.request.contextPath}/images/search_icon.png');">
			</li>
				</ul>
			<div class="select-wrapper">
			<select name="shopOrder" id="shopOrder">
				<option value="1" <c:if test="${param.order == 1 }">selected</c:if>>최신순</option>
				<option value="2" <c:if test="${param.order == 2 }">selected</c:if>>구매순</option>
				<option value="3" <c:if test="${param.order == 3 }">selected</c:if>>후기순</option>
				<option value="4" <c:if test="${param.order == 4 }">selected</c:if>>평점순</option>
				<option value="5" <c:if test="${param.order == 5 }">selected</c:if>>관심상품순</option>
			</select>	
			</div>
		</form>
	</div>
	<div class="shop-product-page">
		<div class="shop-product">
			<div class="product-item" onclick="window.location.href='shopDetail'"> <!-- 이거 실제로 구현할 때는 이름에 sequence 붙여서 나오게 해야 할듯 구분을 주기 위해 -->
				<img src="${pageContext.request.contextPath}/images/cje/product.png" alt="티셔츠">
			    <h3>MARVEL</h3>
				<p>클래식 티셔츠(아이보리)</p>
			    <p class="product-price">39,000</p>
			</div>	
		<div class="product-item">
						<img src="${pageContext.request.contextPath}/images/cje/product.png" alt="티셔츠">
					    <h3>MARVEL</h3>
						<p>클래식 티셔츠(아이보리)</p>
					    <p class="product-price">39,000</p>
					</div>		
				<div class="product-item">
								<img src="${pageContext.request.contextPath}/images/cje/product.png" alt="티셔츠">
							    <h3>MARVEL</h3>
								<p>클래식 티셔츠(아이보리)</p>
							    <p class="product-price">39,000</p>
							</div>		
						<div class="product-item">
										<img src="${pageContext.request.contextPath}/images/cje/product.png" alt="티셔츠">
									    <h3>MARVEL</h3>
										<p>클래식 티셔츠(아이보리)</p>
									    <p class="product-price">39,000</p>
									</div>		
								<div class="product-item">
												<img src="${pageContext.request.contextPath}/images/cje/product.png" alt="티셔츠">
											    <h3>MARVEL</h3>
												<p>클래식 티셔츠(아이보리)</p>
											    <p class="product-price">39,000</p>
											</div>		
										<div class="product-item">
														<img src="${pageContext.request.contextPath}/images/cje/product.png" alt="티셔츠">
													    <h3>MARVEL</h3>
														<p>클래식 티셔츠(아이보리)</p>
													    <p class="product-price">39,000</p>
													</div>		
												<div class="product-item">
																<img src="${pageContext.request.contextPath}/images/cje/product.png" alt="티셔츠">
															    <h3>MARVEL</h3>
																<p>클래식 티셔츠(아이보리)</p>
															    <p class="product-price">39,000</p>
															</div>		
														<div class="product-item">
																		<img src="${pageContext.request.contextPath}/images/cje/product.png" alt="티셔츠">
																	    <h3>MARVEL</h3>
																		<p>클래식 티셔츠(아이보리)</p>
																	    <p class="product-price">39,000</p>
																	</div>		
																<div class="product-item">
																				<img src="${pageContext.request.contextPath}/images/cje/product.png" alt="티셔츠">
																			    <h3>MARVEL</h3>
																				<p>클래식 티셔츠(아이보리)</p>
																			    <p class="product-price">39,000</p>
																			</div>		
																		<div class="product-item">
																						<img src="${pageContext.request.contextPath}/images/cje/product.png" alt="티셔츠">
																					    <h3>MARVEL</h3>
																						<p>클래식 티셔츠(아이보리)</p>
																					    <p class="product-price">39,000</p>
																					</div>		
																				<div class="product-item">
																								<img src="${pageContext.request.contextPath}/images/cje/product.png" alt="티셔츠">
																							    <h3>MARVEL</h3>
																								<p>클래식 티셔츠(아이보리)</p>
																							    <p class="product-price">39,000</p>
																							</div>		
																						<div class="product-item">
																										<img src="${pageContext.request.contextPath}/images/cje/product.png" alt="티셔츠">
																									    <h3>MARVEL</h3>
																										<p>클래식 티셔츠(아이보리)</p>
																									    <p class="product-price">39,000</p>
																									</div>																																										</div>
		</div>				
	</div>

<!-- 벌스샵 끝-->