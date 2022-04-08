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
String speakers[] = {"mijin", "jinho", "clara", "matt", "shinji", "meimei", "liangliang", "jose",
		"carmen", "nnaomi", "nhajun", "ndain"};
String[] speakerinforms = {"미진:한국어, 여성음색", "진호:한국어, 남성음색", "클라라:영어, 여성음색", "매드:영어, 남성음색", 
	      "신지:일본어, 남성음색", "메이메이:중국어, 여성음색", "량량:중국어, 남성음색", "호세:스페인어, 남성음색", "카르멘:스페인어, 여성음색",
	      "나오미:일본어, 여성음색", "하준:한국어, 남아음색", "다인:한국어, 여아음색"};
%>

<form action = "/ttsresult" method = "get">
언어 선택 : <br>
<%
for(int i = 0; i < speakers.length; i++) {
%>	
	<input type = radio name = "speaker" value = "<%=speakers[i]%>"> <%=speakerinforms[i]%><br>
<%	
}
%>

텍스트파일 선택: <br>
<select name = "textfile">
<% 
String[] filelist = (String[])request.getAttribute("filelist");
for (int i = 0; i < filelist.length; i++) {
	String onefile = filelist[i];
	String[] onefile_split = onefile.split("[.]"); // split(".")은 정규 표현식으로 인식됨. .은 아무 글자 1개를 뜻.
	System.out.println(onefile_split.length);
	String ext = onefile_split[onefile_split.length-1];
	
	if(ext.equals("txt")) {
%>
		<option value = "<%=onefile%>"><%=onefile%></option>
<% 	}
}
%>

</select>
	<input type = "submit" value = "음성으로 변환">
</form>
</body>
</html>