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
	<script
	  src="https://code.jquery.com/jquery-3.6.0.js"
	  integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	  crossorigin="anonymous"></script>
	  
<script type="text/javascript">
	$(document).ready(function(){
		// mycanvas 객체 (body태그 안의 캔버스 태그 id)
		let mycanvas = document.getElementById("mycanvas");
		// 캔버스의 붓 
		let mycontext = mycanvas.getContext("2d");
		
		//이미지 canvas=이미지위에다른요소 렌더링 추가
		let faceimage = new Image(); // 이미지 객체 생성 
		faceimage.src = "/naverimages/${param.image }";
		faceimage.onload = function(){ // 이미지 객체, 시작 좌표 x, y, 이미지 넓이, 이미지 높이 
			// canvas.drawImage: 그리기 (만약 다른 곳으로 얼굴 복사하고 싶으면 putimage메서드 사용)
			mycontext.drawImage(faceimage, 0, 0, faceimage.width, faceimage.height);
		// 자바스크립트 코드 end 
		
		//jsp코드
			<% 
			String faceresult = (String)request.getAttribute("faceresult3");
			JSONObject total =  new JSONObject(faceresult);
			JSONObject info = (JSONObject) total.get("info");
			int facecount = (Integer)info.get("faceCount");

			JSONArray faces = (JSONArray)total.get("faces");

			for(int i = 0; i < faces.length(); i++){
				JSONObject oneface = (JSONObject)faces.get(i);
				JSONObject roi = (JSONObject)oneface.get("roi");
				int x = (Integer)roi.get("x");
				int y = (Integer)roi.get("y");
				int width = (Integer)roi.get("width");
				int height = (Integer)roi.get("height");
			%>
			    //자바스크립트 mycanvas 영역 사각형 얼굴 그리기(자바스크립트 코드. 반복문 끝나기 전에 jsp코드 더이상 사용 x)
			    mycontext.lineWidth = 3;
			    mycontext.strokeStyle = "pink";
			    mycontext.strokeRect(<%=x%>,<%=y%>,<%=width%>,<%=height%>);
			    
			    // 모자이크 
<%-- 			    mycontext.fillStyle = "pink";
			    mycontext.fillRect(<%=x%>,<%=y%>,<%=width%>,<%=height%>);
 --%>
			<%
			}
			%>
		}//faceimage.onload end
		
	});//ready end
</script>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
</head>
<body>

<canvas id="mycanvas" width=800 height=800 style="border:2px solid gray"></canvas>

</body>
</html>


