<%@page import="java.math.BigDecimal"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="<%=request.getContextPath()%>/resources/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
	//jquery code
		
	});
</script>
</head>
<body>
<h3>얼굴 인식 서비스 호출 결과는 ${faceresult } 입니다</h3>

<!-- {
"info":
	{"size":{"width":640,"height":640},
	 "faceCount":1},
"faces":
	[
		{"celebrity":{"value":"아이유","confidence":1.0}}
	]
} 
-->
<%
String faceresult = (String)request.getAttribute("faceresult");
JSONObject total = new JSONObject(faceresult);
JSONObject info = (JSONObject)total.get("info"); //{"size":{"width":640,"height":640},"faceCount":1}
int facecount = (Integer)info.getInt("faceCount"); //1

JSONArray faces = (JSONArray)total.get("faces"); //[{"celebrity":{"value":"아이유","confidence":1.0}}]

for(int i = 0; i < faces.length(); i++){
	JSONObject oneface = (JSONObject)faces.get(i);
	JSONObject celebrity = (JSONObject)oneface.get("celebrity");
	String value = (String)celebrity.get("value"); //"아이유"
	BigDecimal confidence = (BigDecimal)celebrity.get("confidence");
	double confidencedouble = confidence.doubleValue();
	
	out.println("<h1>" + value + "유명인을 " + 
	Math.round(confidencedouble * 100) + " 퍼센트로 닮았습니다.</h1>");
}

%>

<h3><%=facecount %> 명의 얼굴을 찾았습니다.</h3>
</body>
</html>