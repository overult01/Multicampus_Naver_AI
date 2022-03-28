<%@page import="java.math.BigDecimal"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>네이버 얼굴인식 API 예제2(얼굴 감정 나이 성별 좌표)</title>
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
${faceresult2}
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
//전체결과(getAttribute는 Object를 리턴하므로 String으로 형변환)
String faceresult = (String)request.getAttribute("faceresult2");

//전체결과(json으로 바꿨을 때)
JSONObject total =  new JSONObject(faceresult);

//1회 파싱
JSONObject info = (JSONObject) total.get("info");
//최종 파싱(2회)
int facecount = (Integer)info.get("faceCount");

//1회 파싱(배열리턴: JSONArray)
JSONArray faces = (JSONArray)total.get("faces");
//최종 파싱(2회, 배열파싱)
for(int i = 0; i < faces.length(); i++){
	JSONObject oneface = (JSONObject)faces.get(i);
	JSONObject roi = (JSONObject)oneface.get("roi");
	int x = (Integer)roi.get("x");
	int y = (Integer)roi.get("y");
	int width = (Integer)roi.get("width");
	int height = (Integer)roi.get("height");
	out.println
	("<h3>얼굴위치는 x좌표(왼쪽)" + x + " , y좌표(아래로) "
	+ y + " 위치부터 시작하여 "
	+ " 가로크기 " + width 
	+ " 세로크기 " + height + " 의 크기를 가집니다. </h3>");
	
	//성별 나이 감정 자세 
	JSONObject gender  = (JSONObject)oneface.get("gender");
	String genderString = (String)gender.get("value");
	JSONObject age  = (JSONObject)oneface.get("age");	
	String ageString = (String)age.get("value");
	
	JSONObject emotion  = (JSONObject)oneface.get("emotion");
	String emotionString = (String)emotion.get("value");
	
	JSONObject pose  = (JSONObject)oneface.get("pose");
	String poseString = (String)pose.get("value");
	
	out.println("<h3>성별 = " + genderString + "</h3>");
	out.println("<h3>나이 = " + ageString + "</h3>");
	out.println("<h3>감정 = " + emotionString + "</h3>");
	out.println("<h3>자세 = " + poseString + "</h3>");
	
	//landmark - 왼눈 오른눈 코 왼쪽입오른입좌표 5개  
	//json null --> "null"
	if(!oneface.get("landmark").equals(null)){
	JSONObject landmark  = (JSONObject)oneface.get("landmark");
	JSONObject nose  = (JSONObject)landmark.get("nose"); //{x:..y:...}
	out.println("<h3>코 = " + (Integer)nose.get("x")+":"+ (Integer)nose.get("y")  + "</h3>");
	}
	else{
		out.println("<h3>눈코입을 파악할 수 없습니다</h3>");
	}
	
}



%>
<!-- 변수출력  -->
<h1> <%=facecount %> 명의 얼굴을 찾았습니다.</h1>
<!-- 컨트롤러 메서드로부터 전달받은 파라미터 -->
<img src="/naverimages/${param.image }"> 


</body>
</html>




