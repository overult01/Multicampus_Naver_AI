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
<title>네이버 얼굴인식 API 예제1(유명인 닮은 정도)</title>
<script src="<%=request.getContextPath()%>/resources/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
	//jquery code
		
	});
</script>
</head>
<body>
<h3>얼굴 인식 서비스 호출 결과는 ${faceresult } 입니다(json형태)</h3>

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

<h3>json형태를 parsing</h3>
<%
// 전체결과(getAttribute는 Object를 리턴하므로 String으로 형변환)
String faceresult = (String)request.getAttribute("faceresult");

// 전체결과(json으로 바꿨을 때)
JSONObject total = new JSONObject(faceresult);

// 1회 파싱
JSONObject info = (JSONObject)total.get("info"); //{"size":{"width":640,"height":640},"faceCount":1}
// 최종 파싱(2회)
int facecount = (Integer)info.getInt("faceCount"); //1

// 1회 파싱(배열리턴: JSONArray)
JSONArray faces = (JSONArray)total.get("faces"); //[{"celebrity":{"value":"아이유","confidence":1.0}}]

//최종 파싱(2회, 배열파싱)
for(int i = 0; i < faces.length(); i++){
	JSONObject oneface = (JSONObject)faces.get(i); // 1사람에 대한 정보
	JSONObject celebrity = (JSONObject)oneface.get("celebrity");
	String value = (String)celebrity.get("value"); //"아이유"
	// BigDecimal: 범위가 큰 실수. (Double로 하면 뒤에가 끊긴다.)
	BigDecimal confidence = (BigDecimal)celebrity.get("confidence");
	// BigDecimal.doubleValue() : 실수로 바꿔주는 메서드
	double confidencedouble = confidence.doubleValue();
	
	out.println("<h1>" + value + "유명인을 " + 
	Math.round(confidencedouble * 100) + " 퍼센트로 닮았습니다.</h1>");
}

%>

<h3><%=facecount %> 명의 얼굴을 찾았습니다.</h3>
</body>
</html>