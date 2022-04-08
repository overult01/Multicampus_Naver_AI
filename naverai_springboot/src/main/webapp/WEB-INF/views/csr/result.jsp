<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script
	  src="https://code.jquery.com/jquery-3.6.0.js"
	  integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	  crossorigin="anonymous">
</script>
<script>
$(document).ready(function() {

});
</script>

<body>

<h3>변환결과: ${result }</h3>
음성파일: 
<audio src = "/naverimages/${param.image }" controls="controls"></audio> <!-- controls만 써도 됨. 이것이 있어야 음량 조절 가능  -->
<%-- ${param.image } : 사용자가 선택한 음성파일  --%>
</body>
</html>