<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:getAsString name="title" /></title>
<link href="${pageContext.request.contextPath}/images/cmj/logo.png"
	rel="shortcut icon" type="image/x-icon">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/admin.css" type="text/css"> 
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/share.css" type="text/css">
<tiles:insertAttribute name="css" ignore="true" />

</head>
<body>
	<div id="main">
		<div class="page-container">
			<div id="body">
				<tiles:insertAttribute name="admin_nav"/>
				<tiles:insertAttribute name="admin_body" />
			</div>
		</div>
		<div id="footer">
			<tiles:insertAttribute name="footer"/>
		</div>
	</div>
</body>
</html>