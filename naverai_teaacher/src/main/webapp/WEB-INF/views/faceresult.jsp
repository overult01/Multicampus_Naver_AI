<%@page import="java.math.BigDecimal"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
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
<h3>
얼굴 인식 서비스 호출 결과는 
${faceresult}
입니다
</h3>

<!-- 
 {
 "info":
 {"size":{"width":264,"height":200},"faceCount":1},
 "faces":[
 {"celebrity":{"value":"송혜교","confidence":0.731665}}0-1
 ]
 }
 -->
<%
String faceresult = (String)request.getAttribute("faceresult");
JSONObject total =  new JSONObject(faceresult);
JSONObject info = (JSONObject) total.get("info");
int facecount = (Integer)info.get("faceCount");

JSONArray faces = (JSONArray)total.get("faces");

for(int i = 0; i < faces.length(); i++){
	JSONObject oneface = (JSONObject)faces.get(i); // [{"celebrity":{"value":"송혜교","confidence":0.731665}} ,,,,]
	JSONObject celebrity = (JSONObject)oneface.get("celebrity");//{"value":"송혜교","confidence":0.731665}	
	String value = (String)celebrity.get("value");//"송혜교"
	BigDecimal confidence = (BigDecimal)celebrity.get("confidence");//0.2222
	double confidencedouble = confidence.doubleValue();
	//Math.random(73)
	out.println("<h1>" + value  + " 유명인을 " + 
	Math.round(confidencedouble *100) + " 퍼센트로 닮았습니다.</h1>");
}


%>

<h1> <%=facecount %> 명의 얼굴을 찾았습니다.</h1>



</body>
</html>