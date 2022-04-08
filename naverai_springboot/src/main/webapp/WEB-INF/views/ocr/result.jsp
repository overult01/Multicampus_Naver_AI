<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>수정필요(캔버스가 안그려지는 상)</title>
</head>
<script
	  src="https://code.jquery.com/jquery-3.6.0.js"
	  integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	  crossorigin="anonymous">
</script>
<script>
$(document).ready(function() {
	
	var json = JSON.parse('${ocrresult }');
	
	// 이미지 그리기 
	var canvas = document.getElementById("canvas");
	var context = canvas.getContext("2d");
	
	var image = new Image();
	image.src = "/naverimages/${param.fontfile}";
	image.onload = function(){
		context.drawImage(image, 0, 0, image.width, image.height);
		context.strokeStyle = "green";
		context.lineWidth = "2px";
	
	var fieldslist = json.images[0].fields; // 이미지 내부의 글씨들을 공백으로 분리 -> 여러 단어들이 들어가 있는 배열
	for(var i in fieldslist){
		if(fieldslist[i].lineBreak == true){ // 줄바꿈 여부 
			$("#result2").append("&nbsp;"+ fieldslist[i].inferText + "<br>");	// 원래 공백 있으면 줄바꿈처리 
		}
		else {
			$("#result2").append("&nbsp;"+ fieldslist[i].inferText);			
		}
		
		// 캔버스 위 텍스트 위치별 박스화(4개 점: 1개 점당 x,y)
//		context.strokeRect(x좌표, y좌표, 가로, 세로);
		var canvas_x = fieldslist[i].boundingPoly.vertices[0].x;
		var canvas_y = fieldslist[i].boundingPoly.vertices[0].y;
		var width = fieldslist[i].boundingPoly.vertices[1].x - canvas_x;
		var height = fieldslist[i].boundingPoly.vertices[3].y - canvas_y;
		
		context.strokeRect(canvas_x, canvas_y, width, height);
		
		
	} // for end
	} // image.onload end
		
});
</script>

<body>

<div id = "result" style = "border:2px solid green">${ocrresult }</div> <%-- ${} : jsp el표현  --%>
<div id = "result2" style = "border:2px solid blue">분석할 텍스트 보여주는 곳</div>
<canvas id = "canvas" style = "2px solid red" width = 500 height = 500></canvas>

</body>
</html>