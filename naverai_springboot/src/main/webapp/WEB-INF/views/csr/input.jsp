<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
String[] languages = {"Kor", "Eng", "Chn", "Jpn"};
String[] languagesnames = {"한국어", "영어", "중국어", "일본어"};
%>

<form action = "/csrresult" method = "get">
언어 선택 : <br>
<%
for(int i = 0; i < languages.length; i++) {
%>	
	<input type = radio name = "lang" value = "<%=languages[i]%>"> <%=languagesnames[i]%><br>
<%	
}
%>

mp3파일 선택: <br>
<select name = "image">
<% 
String[] filelist = (String[])request.getAttribute("filelist");
for (int i = 0; i < filelist.length; i++) {
	String onefile = filelist[i];
	String[] onefile_split = onefile.split("[.]"); // split(".")은 정규 표현식으로 인식됨. .은 아무 글자 1개를 뜻.
	System.out.println(onefile_split.length);
	String ext = onefile_split[onefile_split.length-1];
	
	if(ext.equals("mp3") || ext.equals("m4a")) {
%>
		<option value = "<%=onefile%>"><%=onefile%></option>
<% 	}
}
// mp3filelist = {null, a.mp3, null, ..} 이런 형식
%>

</select>
	<input type = "submit" value = "텍스트 변환">
</form>
</body>
</html>