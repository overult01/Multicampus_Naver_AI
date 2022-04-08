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

<%
String[] imageext = {"jpg", "jpeg", "png", "jfif", "gif"};
String[] filelist = (String[])request.getAttribute("filelist"); // 모든 확장자 파일 
for(int i = 0; i < filelist.length; i++) { // 모든 파일 대상
	String onefile = filelist[i];
	String[] onefilesplit = onefile.split("[.]");
	String ext = onefilesplit[onefilesplit.length-1]; // 각 파일의 확장자 
	
	for(int j = 0; j < imageext.length; j++){
		if(ext.equals(imageext[j])) {
%>
			<a href = "/ocrresult?fontfile=<%=onefile%>"> <%=onefile%> </a>			
			<img src = "/naverimages/<%=onefile%>" width = 100 height = 100> <br>
<% 		} // if end
	} // for end	
}
%>


</body>
</html>