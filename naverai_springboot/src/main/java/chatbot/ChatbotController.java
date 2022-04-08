package chatbot;

import java.awt.Event;
import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import basic.naver.api.NaverService;

//@Controller
public class ChatbotController {

	@Autowired
	@Qualifier("chatbotservice")
	ChatbotServiceImpl service;
	
	@Autowired
	@Qualifier("chatbotttsservice")
	ChatbotTTSServiceImpl ttservice;

	@Autowired
	@Qualifier("chatbotsttservice")
	ChatbotSTTServiceImpl sttservice;
	
	
	@RequestMapping("/chatbotrequest")
	public String chatbotrequest() {
		return "chatbot/request";
	}
	
	@RequestMapping("/chatbotresponse")
	public ModelAndView chatbotresponse(String request, String event) {
		
		String response = "";
		
		ModelAndView mv = new ModelAndView();
		
		if (event.equals("답변")) { // jsp의 input태그의 name = "event" 중에서 value 값으로 알아온다.
			response = service.test(request); // test메서드에서 질문만 보내도 send로 되도록 만들었다.
		}
		else if (event.equals("웰컴메세지")) {
			response = service.test(request, "open");
		}
		mv.addObject("response", response);
		mv.setViewName("chatbot/response");
		return mv;
	}
	
	// 음성으로 답변듣기  
	// ajax로 답변 추가 
	@RequestMapping("/chatbotajax")
	public String chatbotajax() {
		return "chatbot/chatbotajax(1)";
	}

	// ajax로 답변하는 메서드
	@RequestMapping("/chatbotajax2")
	@ResponseBody // @ResponseBody 가 붙어있고, String 리턴타입이면 json형태로 리턴된다.(뷰가 아님) 
	public String chatbotajax2(String request, String event) { // 클라이언트측에서 ajax요청시 전달받은 request 
		System.out.println(event);
		
		String response = "";
		
		if ("답변".equals(event)) { // jsp의 input태그의 name = "event" 중에서 value 값으로 알아온다.
			response = service.test(request); // test메서드에서 질문만 보내도 send로 되도록 만들었다.
		}
		else if ("웰컴메시지".equals(event)) {
			response = service.test(request, "open");
		}
		return response; // service.test는 json형태를 리턴.
	}

	// 음성으로 질문하기 
	@RequestMapping("/chatbottts")
	@ResponseBody // return 값이 현재 뷰에 저달되는 결과물 
	public String chatbottts(String text) {
		String mp3file = ttservice.test(text); // 기본 음성으로 바뀐 음성파일
		return mp3file;
	}
	
	@RequestMapping(value = "/mp3upload", method = RequestMethod.POST)
	@ResponseBody
	// spring mvc 프로젝트 : pom.xml 라이브러리 태그 추가
	// springboot : 파일업로드 라이브러리 기본 내장 
	public String mp3upload(MultipartFile file1) throws IllegalStateException, IOException {
		String filename = file1.getOriginalFilename(); // 전달한 파일의 이름 
		String path = "/Users/jungmin/Desktop/kdt-venture/workspace/AI/naverai_springboot/ai_images/";
		
		File savefile = new File(path + filename);
		file1.transferTo(savefile); // transferTo: savefile에 전달된 파일 복사
		return "잘 받았습니다";
	}
	
	@RequestMapping(value = "/chatbotstt")
	@ResponseBody
	public String mp3Totext(String filename) {
		// 1. filename 요청 파라미터 값을 전달받아서
		// 2. ChatbotSTTService test에 전달
		// 3. 값을 리턴받는다
		String text = sttservice.test(filename);
		// 요청했던 뷰로 3번을 리턴한다.
		return text; // {"text" : ..}
		
	}
	
	
}
