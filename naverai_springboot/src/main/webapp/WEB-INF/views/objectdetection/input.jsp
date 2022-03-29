<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>네이버 얼굴인식 API 예제3(사물인식)</title>
</head>
<body>
<c:forEach items="${filelist }" var="onefilename">
	<h3><a href = "/objectdetectionresult/?image=${onefilename }">${onefilename }
	<img src="/naverimages/${onefilename } " width=100 height=100></a></h3>
</c:forEach>
</body>
</html>