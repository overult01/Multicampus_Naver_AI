<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="resources/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		//jquery code
	});
</script>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
</head>
<body>
<c:forEach items="${filelist }" var="onefilename">
	<h3>
		<a href="/faceresult2?image=${onefilename }" >${onefilename }</a>
		<img src="/naverimages/${onefilename }" width=100 height=100 >
	</h3>
</c:forEach>
</body>
</html>