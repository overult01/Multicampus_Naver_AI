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

<table border = 1>
	<tr><td>질문</td><td>답변</td><td>음성으로 듣기</td></tr>
	<tr><td>${question }</td><td>${response }</td><td><audio id = "mp3" controls = "controls" src="/naverimages/${mp3file}"></audio></td></tr>
</table>

</body>
</html>