<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax여러 메서드 호출</title>
<script
	  src="https://code.jquery.com/jquery-3.6.0.js"
	  integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	  crossorigin="anonymous">
</script>
<script type="text/javascript">
	$(document).ready(function(){
//		$("#event1").on('click', function(){
		$("input:button").on('click', function(){
			$("#response").append("질문 : " + $("#request").val() +"<br>");//질문내용을 대화창 복사
			
			$.ajax({
				url : "/chatbotajax2",  
				data : {'request' : $("#request").val(), "event":$(this).val()},
				type : 'get' , 
				dataType:'json',
				success:function(serverdata){
					
				var bubbles = serverdata.bubbles;
				for(var b in bubbles){
					//기본답변일때
					if(bubbles[b].type == 'text'){
						$("#response").append(bubbles[b].data.description +"<br>");
						$.ajax({
							url : '/chatbottts', 
							type:'get', 
							data :{'text' : bubbles[b].data.description},
							success:function(mp3file){
								var audio = document.getElementById("tts");
								audio.src = "/naverimages/"+mp3file;
								audio.play();//재생버튼 클릭 동일 효과
								
								
								//var audio = $("#tts");
								//audio.get(0).src = "";
								//audio.attr('src',  "/naverimages/"+mp3file);

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
		
		$("#request").val('');//질문창 리셋
		
		});//event1 onclick

/* 		$("#event2").on('click', function(){
		});//event2 onclick */
		
	});//ready end
</script>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
</head>
<body>
	질문입력 : <input type=text id="request" >
	<input type=button value="답변" id="event1" name = "event">
	<input type=button value="웰컴메시지" id="event2" name = "event">	
	<button id="record">음성질문시작</button>
	<button id="stop">음성질문종료</button>
	<div id="sound"></div> 
	<br>
	대화:<div id="response" style="border:2px solid aqua"></div>
	<audio id="tts"  controls="controls"></audio>
</body>

	
	<!-- 음성질문처리구현코드 -->
	<script>
 var record = document.getElementById("record");//녹음버튼
 var stop = document.getElementById("stop");//정지버튼
 var sound = document.getElementById("sound");//오디오태그출력예정
 
 if(navigator.mediaDevices){//녹음기 카메라 지원 브라우저니
	 console.log("지원가능");
	 var constraints = {audio:true};//녹음기
 }
 
 var chunks=[] //녹음내용임시저장예정
 navigator.mediaDevices.getUserMedia(constraints)
 .then(function(stream){
	 var mediaRecorder = new MediaRecorder(stream);
	 record.onclick = function(){
		 mediaRecorder.start();
		 record.style.color = "blue";
		 record.style.background = "red";//녹음버튼클릭하면 녹음진행중이고 버튼 파랑색글씨빨간색배경
	 }//
	 stop.onclick = function(){
		 mediaRecorder.stop();
		 record.style.color = "";
		 record.style.background = "";		 
	 }//

 //녹음시작상태이면 chunks 에 녹음데이터를 저장하라
 mediaRecorder.ondataavailable = function(e){
	 chunks.push(e.data);
 }//ondataavailable end
 
 //녹음정지상태이면 실행하라
  mediaRecorder.onstop = function(e){
	 //audio 태그 추가
	 var audio = document.createElement('audio');
	 //<audio></audio>
	 audio.setAttribute("controls", '');
	 audio.controls = true;
	 //<audio controls="controls"></audio>
	 sound.appendChild(audio);
	 //<div id="sound">  <audio controls="controls"></audio> </div>
	
	 //녹음 데이터 가져와라+ 오디오태그재생 세팅
	 var blob = new Blob(chunks , {"type":"audio/mp3"});
	 var mp3url = URL.createObjectURL(blob);
	 audio.src = mp3url;
	 
	 //다음 녹음 위해 chunks 초기화
	 chunks = [];
	 
	//파일명 : 현재시각+ mp3 설정
	// text <--ChatbotSTTSERVICE test (mp3파일) 
	// ajax - 요청  - 파일전달(MultipartFile, multipart/form-data data-form
	// 녹음컴퓨터에서 스프링부터서버로 파일업로드 	+ ajax	
	//ajax file upload
	var formData = new FormData();//<form태그 데이터저장..>
	formData.append("file1", blob, "a.mp3");
	$.ajax({
	url: "/mp3upload",
	data : formData,
	type:'post',
	processData : false,
	contentType : false,
	success : function(server){
		alert(server);
		if( server == "잘 받았습니다"){
			$.ajax{( // 스프링 서버가 ChatbotSTTServiceImpl test메서드 호출한 뒤 (텍스트로 변환된)결과 가져오기 
					url: "/chatbotstt",
					data: {'filename' : 'a.mp3'}, // 나중에 파일명 바꾸기 
					type: "get",
					
					dataType: 'json',
					success: function(server){ 
						alert(server.text);
						$("#request").val(server.text); // 받은 내용 중 text속성의 값을 val함수로 넣어주기 . {"text" : ..}
						
						}
					)}; // ajax end 
			
			} // if end 
		} // success end
	}
	});

	
	 
 }//onstop end
 })//then end
 .catch(function(err){console.log("오류발생 " + err);})//catch end
 
</script>
	

</html>
