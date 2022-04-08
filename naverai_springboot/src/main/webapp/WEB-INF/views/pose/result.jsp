<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
	<script
	  src="https://code.jquery.com/jquery-3.6.0.js"
	  integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	  crossorigin="anonymous"></script>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<script>
	$(document).ready(function() {

		// 전체결과 출력(json형태)
		// $("#output").html('${result}');
		var json = JSON.parse('${result}');
		
		var canvas = document.getElementById("canvas");
		var context = canvas.getContext("2d");
		
		var image = new Image();
		image.src = "/naverimages/${param.image}";
		
		// 이미지가 로드될 때까지 기다린다(onload)
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
		
		for (var i = 0; i < poseinforms.length; i++) {
			context.fillStyle = colorinforms[i];
			context.fillText(poseinforms[i]
			, json.predictions[0][i].x * image.width
			, json.predictions[0][i].y * image.height
			);
			
			// 왼손목, 오른손목 연결 라인 그리기 
			if (poseinforms[i].indexOf("왼손목" >= 0)) {
				var right_wrist_x = json.poseinforms[0][i].x * image.width;
				var right_wrist_y = json.poseinforms[0][i].y * image.height;
			}
			if (poseinforms[i].indexOf("오른손목" >= 0)) {
				var left_wrist_x = json.poseinforms[0][i].x * image.width;
				var left_wrist_y = json.poseinforms[0][i].y * image.height;
			}
			
			// 선그리기 샘플
 			context.beginPath();
			context.moveTo(left_wrist_x, left_wrist_y);
			context.lineTo(right_wrist_x, right_wrist_y);
			context.closePath();
			context.strokeStyle="red";
			context.lineWidth = 5;			
			context.stroke();
			
			
			
			}; // for end 
		
		} // image onload. (onload가 너무 늦게 실행되는 것을 대비하여 신체 부위 점찍는 코드도 포함)
	});

</script>



<body>


<div id = "output" style = "2px solid green"></div>
<canvas id = "canvas" style = "2px solid pink" width = 500 height = 500"></canvas>

</body>
</html>