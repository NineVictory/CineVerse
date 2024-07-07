<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- 벌스샵 시작 -->
<div class="shop-main">
	<form action="shopSearch" id="shop_search">
		<label>
			<input type="search" name="search" placeholder="검색어를 입력하세요">
			<input type="submit" value="" style="background-image: url('${pageContext.request.contextPath}/images/search_icon.png');">
		<label>
	</form>
</div>
<!-- 벌스샵 끝-->