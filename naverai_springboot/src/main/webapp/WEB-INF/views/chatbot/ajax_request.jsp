<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>챗봇으로 대화만들기(ajax)</title>
</head>
<script
	  src="https://code.jquery.com/jquery-3.6.0.js"
	  integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	  crossorigin="anonymous">
</script>
<script>
$(document).ready(function(){
	$("input:button").on('click', function(){
		
		$("#response").append("질문: " + $("#request").val() + "<br>"); // 질문내용을 대화창으로 복사 
		
		$.ajax({
			// 클라이언트에서 요청
			url: "/chatbotajax2",
			data: {"request" : $("#request").val(), "event":$(this).val()},  /* 보내야할 변수명 : 보내야할속성의 value값. $(this): 제이쿼리에서 this는 현재 클릭하고 있는 그 버튼.  */ 
			type: 'get',
			
			// 응답 수신 (서버로부터 받음)
			dataType: 'json', // json형식으로 받기
			success: function(serverdata){
			
				var bubbles = serverdata.bubbles;
				for(var b in bubbles){
					//기본답변일때
					if(bubbles[b].type == 'text'){
						$("#response").append(bubbles[b].data.description +"<br>");
						
						// tts서비스 추가 
						// tts_voice.TTSService-test(bubbles[b].data.description)
						// 챗봇 컨트롤러에 /chatbottts url에 매핑된 메서드 만들기 - ChatbotTTSServiceImpl test호출 - 모델저장 - 뷰  
						$.ajax({
							url: "/chatbottts",
							data: {"text" : bubbles[b].data.description} , // 넘겨줄 답변 텍스트 
							type: "get",
							
							dataType: "json",
							success: function(mp3){
								var audio = document.getElementById("tts");
								audio.src = "/naverimages/" + mp3;
								// 제이쿼리로 할 때 같은 표현(위는 돔구조) - 자바스크립트, 제이쿼리로 읽어올 때 
								// var audio = $("#tts");
								// audio.attr('src', "/naverimages/" + mp3)
								// audio.get(0).src = .. 도 가능. 제이쿼리로 읽어오고 자바스크립트 표현을 쓰고 싶을 때는 .get(0) 메서드 사용 
								
								// 자동재생. 재생버튼 누른 것ㄱ ㅘ 같음
								audio.play();
							}
						});
						
					}
					else if(bubbles[b].type == 'template'){
					//이미지답변일때
						if(bubbles[b].data.cover.type == "image"){
							$("#response").append("<img src=" + bubbles[b].data.cover.data.imageUrl + " width=200 height=200><br>");
				
						}//if end
						else if(bubbles[b].data.cover.type == "text"){//멀티링크답변일때
							$("#response").append(bubbles[b].data.cover.data.description +"<br>");
						    for(var c in bubbles[0].data.contentTable){
						      for(var d in bubbles[0].data.contentTable[c]){
						    	  var link = bubbles[0].data.contentTable[c][d].data.title;
						       	  var href=bubbles[0].data.contentTable[c][d].data.data.action.data.url;
						       	$("#response").append("<a href=" + href + ">" + link + "</a><br>");
						      }
						    }//for end
						}//else if end
					
					
					}
				}//for end
				}//success end
			});//ajax end
		
			$("#request").val(""); // 질문창 리셋 
			
		});//event1 onclick
	});//ready end
</script>

<body>
	
<!-- 	ajax는 form태그 없다  -->
	질문입력 : <input type = text id = "request">
	<input type = button value = "답변" id = "event1" > <!-- name 속성: 컨트롤러에서 받는 속성,  id 속성: 자바스크립트가 받는 속성 --> 
	<input type = button value = "웰컴메세지" id = "event2">
	<button id = "record">음성질문 시작</button>
	<button id = "stop">음성질문 종료</button>
	<div id = "sound">audio 태그 생성</div>
	<br>
대화: <div id = "response" style = "border: 2px solid aqua"></div>
음성으로 듣기: <audio id = "tts" controls = "controls"></audio> <!-- controls: 재생버튼  -->
<!-- 음성 질문 처리 구현 코드  -->
<script type="text/javascript">
var record = document.getElementById("record");
var stop = document.getElementById("stop");
var sound = document.getElementById("sound"); // 오디오태그 출력예정(녹음한 부분 확인)

if(navigator.mediaDevices){ // 녹음기, 카메라 지원하는 브라우저인지 확인 
	console.log("지원가능");
	var constraints = {audio : true}; // 녹음기 사용		
}

var chunks = []; // 녹음 내용 임시 저장 예정
navigator.mediaDevices.getUserMedia(constraints)
.then(function(stream){
	var mediaRecorder = new MediaRecorder(stream); // stream에 녹음되는 내용 저장 
	record.onclick = function(){
		mediaRecorder.start(); // 녹음 시작
		record.style.color = "blue";
		record.style.background = "red"; // 녹음시에는 버튼 파란 글씨, 빨간 배경
	}
	stop.onclick = function() {
		mediaRecorder.stop(); // 녹음 종료
		record.style.color = ""; // 색 해제 
		record.style.background = ""; 
	}
	

// 녹음 시작 상태이면 chunks에 녹음 데이터를 저장
mediaRecorder.ondataavailable = function(e){
	chunks.push(e.data); // e.data: 녹음이 되어지고 있는 데이터 
}

// 녹음 정지상태이면 실행
mediaRecorder.onstop = function(e){

	// audio 태그 추가
	// <audio controls = "controls"></audio>
	var audio = document.createElement('audio');		
	audio.setAttribute("controls", '');
	audio.controls = true;
	// div태그 안에 audio태그 넣기
	sound.appendChild(audio);
	
	// chuncks에 있는 녹음 데이터 -> mp3형태, 오디오 태그 재생 세팅 
	var blob = new Blob(chunks, {"type" : 'audio/mp3'}); // 멀티미디어 데이터는 Blob형태
	var mp3url = URL.createObjectURL(blob);
	audio.src = mp3url;
	
	// 다음 녹음 위해 chuncks 초기화
	chunks = [];
	
	// 자동저장(파일명: 현재시각 + mp3설정) 
	// CSEServiceImpl의 test메서드 호출 
	// ajax - 요청 - 파일전달(MultipartFile)
	// 녹음컴퓨터 -> 스프링부트 서버로 파일업로드 + ajax
	// ajax file upload. 녹음된 파일을 클라이언트에서 서버(스프링부트)에 ajax로 업로드 
	var formData = new FormData(); // <form태그 데이터저장>
	formData.append("file1", blob, "a.mp3");
	$.ajax({
		url: "/mp3upload",
		data: { formData}, // 파일 전송
		type: "post", // 파일 전송은 무조건 post
		processData: false,
		contentType: false,
		success: function(server){
			alert(server);
		}
	})
	
}// onstop end
}) // then end
.catch(function(err){ // 에러발생시
console.log("오류발생 : " + err);
}) // catch end 
</script>

</body>
</html>