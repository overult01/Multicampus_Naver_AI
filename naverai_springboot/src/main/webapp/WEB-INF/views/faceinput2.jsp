<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</script>
</head>
<body>
<c:forEach items="${filelist }" var="onefilename">
	<h3><a href = "faceresult2?image=${onefilename }">${onefilename }
	<img src="/naverimages/${onefilename } " width=100 height=100></a></h3>
</c:forEach>
</body>
</html>