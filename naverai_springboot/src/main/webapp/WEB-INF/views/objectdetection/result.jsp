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
<title>네이버 얼굴인식 API 예제3(사물인식)-자바스크립트로 json 파싱</title>
	<script
	  src="https://code.jquery.com/jquery-3.6.0.js"
	  integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	  crossorigin="anonymous"></script>

<script type="text/javascript">
	$(document).ready(function(){
		//$("#names").html('${objectdetectionresult}') //전체 결과

		// 문자열 데이터를 자바스크립트 json으로 변경하는 함수 호출
		var json = JSON.parse('${result}');
		$("#names").html(json.predictions[0].num_detections + " 개의 사물이 발견되었습니다.");
		
		var name = "";
		var confidence = "";
		
		for(var i = 0; i < json.predictions[0].num_detections; i++){
			name = json.predictions[0].detection_names[i]; // 사물 이름
			confidence = json.predictions[0].detection_scores[i]*100; // 확률 
			$("#names").append("사물: " + name + " 확률: " + confidence + "%<br>");
			//좌표
			/* $("#boxes").append
			(json.predictions[0].detection_boxes[i][0] +", "
			+ json.predictions[0].detection_boxes[i][1] +", "
			+ json.predictions[0].detection_boxes[i][2] +", "
			+ json.predictions[0].detection_boxes[i][3] +"<br>"); */
		}		
		
		
		//캔버스 이미지 표시
		var canvas = document.getElementById("objectcanvas");
		var context = canvas.getContext("2d");
		var image = new Image();
		image.src="/naverimages/${param.image}";
		image.onload = function(){
			
			// drawImage: 이미지 그리기 
			context.drawImage(image, 0, 0, image.width, image.height);
			
			var boxes = json.predictions[0].detection_boxes; //각 사물들의 좌표들 배열
			
			for(var i = 0; i < json.predictions[0].num_detections; i++){
				var y1 = boxes[i][0] * image.height; // 이미지내 위치 : 가져온 좌표 * 이미지 높이 
				var x1 = boxes[i][1] * image.width;
				var y2 = boxes[i][2] * image.height;
				var x2 = boxes[i][3] * image.width;

				// strokeRect: 캔버스에 사각형 그리기 
				context.lineWidth = 3;
				context.strokeStyle = "green"; //선만 있는 네모
				context.strokeRect(x1, y1, x2-x1, y2-y1);
				
				
				// 박스위에 사물이름, 확률을 녹색 바탕 표시
				name = json.predictions[0].detection_names[i]; // 사물 이름
				confidence = Math.round(json.predictions[0].detection_scores[i]*100); // 확률 

				// 글씨의 바탕색 넣기 
				context.fillStyle = "green"; //선만 있는 네모
				context.fillRect(x1, y1, 100, 15); // 너비, 높이는 임의 

				context.fillStyle = "black";
				context.font = "10px batang";
				// fillText(적을 텍스트, x좌표, y좌표) : 캔버스에 텍스트 그리기 
				context.fillText("사물: " + name + " 확률: " + confidence + "%", x1, y1+12);

			}
			
		}//image.onload end
		
		if(image.width > canvas.width) {
			 image.width = canvas.width - 15;
		}
		if(image.height > canvas.height) {
			 image.height = canvas.height - 15;
		}
		
	});//ready end
</script>

</head>
<body>
<h3>사물인식 결과는 ${result } 입니다(json형태)</h3>

<div id = "names" style = "2px solid green"> </div>
<div id = "boxes" style = "2px solid blue"> </div>

<canvas id = "objectcanvas" style = "2px solid pink" width = 500 height = 500> </canvas>

</body>
</html>