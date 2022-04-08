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
		
		//$("#output").html('${poseresult}');//json전체결과출력
		var json = JSON.parse('${result}');
		
		var canvas = document.getElementById("canvas");
		var context = canvas.getContext("2d");
		
		var image = new Image();
		image.src="/naverimages/${param.image}";
		image.onload = function(){
			context.drawImage(image, 0, 0, image.width, image.height);
		
		var poseinforms = ['코' , '목'
				, '오른어깨', '오른팔꿈치', '오른손목', '왼어깨', '왼팔꿈치', '왼손목'
				, '오른엉덩이', '오른무릎', '오른발목', '왼엉덩이', '왼무릎', '왼발목'
				, '오른눈', '오른귀', '왼눈', '왼귀'];

		// xxx.predictions[0][0].x : 첫번째 사람의 코의 x 좌표(몇 퍼센트 위치)
		// xxx.predictions[0][1].x : 첫번째 사람의 목의 x 좌표
		var colorinforms = ["red", "blue", "yellow", "yellow", "yellow", "green", "green", "green",
								"skyblue", "skyblue", "skyblue", "black", "black", "black",
								"pink", "gold", "orange", "brown"];
			
			// 신체 부위별 점을 찍고, 신체 부위 이름 적기
		for(var j = 0; j < json.predictions.length; j++){//사람수만큼 반복
		for(var i = 0; i < poseinforms.length; i++){//현재 8개 신체부위만
		//for(var i in poseinforms.length){
			if(json.predictions[j][i] != null){//신체부위이름 출력
			context.fillStyle=colorinforms[i];
			context.fillText(poseinforms[i],
				json.predictions[j][i].x * image.width, 
				json.predictions[j][i].y * image.height);
			}//if end
		}//inner for end
		}//outer for end
		}//image onload
		
	});
</script>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
</head>
<body>
<div id="output" style="2px solid green"></div>
<canvas id="canvas" style="2px solid pink" width=500 height=500 ></canvas>

</body>
</html>