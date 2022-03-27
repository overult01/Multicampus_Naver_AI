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
<script src="/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		let mycanvas = document.getElementById("mycanvas");
		let mycontext = mycanvas.getContext("2d");
		
		//이미지 canvas=이미지위에다른요소 렌더링 추가
		let faceimage = new Image();
		faceimage.src = "/naverimages/${param.image }";
		faceimage.onload = function(){
			mycontext.drawImage(faceimage, 0, 0, faceimage.width, faceimage.height);
			//jsp코드
			<% 
			String faceresult = (String)request.getAttribute("faceresult2");
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
			    //자바스크립트 mycanvas 영역 사각형 얼굴 그려라
			    mycontext.lineWidth = 3;
			    mycontext.strokeStyle = "pink";
			    mycontext.strokeRect(<%=x%>,<%=y%>,<%=width%>,<%=height%>);
			<%
			}
			%>
		}//faceimage.onload end
		
	});//ready end
</script>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
</head>
<body>
<canvas id="mycanvas" width=500 height=500 style="border:2px solid pink"></canvas>
</body>
</html>


