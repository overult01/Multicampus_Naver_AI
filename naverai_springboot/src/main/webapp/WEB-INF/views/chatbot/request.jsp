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
	
	<form action = "/chatbotresponse">
	질문입력 : <input type = text name = "request">
	<input type = submit value = "답변" name = "event"> <!-- event에 답변 / 웰컴메세지 둘 중 하나 선택  -->
	<input type = submit value = "웰컴메세지" name = "event">
	</form>
</body>
</html>