package chatbot;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.Iterator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ChatbotController_teacher {
	@Autowired
	@Qualifier("chatbotservice")
	ChatbotServiceImpl service;

	@Autowired
	@Qualifier("chatbotttsservice")
	ChatbotTTSServiceImpl ttsservice;
	
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

	@RequestMapping("/chatbotajax2")
	@ResponseBody
	public String chatajax2(String request, String event) {
		//System.out.println(event);
		
		String response = "";
		if(event.equals("답변")) {
			response = service.test(request);
		}
		else if(event.equals("웰컴메시지")) {
			response = service.test(request, "open");
		}
		System.out.println("==>"+response);
		return response;
	}
	
	@RequestMapping("/chatbottts")
	@ResponseBody
	public String chatbottts(String text) {
		String mp3file = ttsservice.test(text);
		return mp3file; 
	}
	
	@RequestMapping(value="/mp3upload", method = RequestMethod.POST)
	@ResponseBody
	//spring mvc project - pom.xml 라이브러리 태그 추가
	//spring boot - 파일업로드 라이브러리 기본 내장
	public String mp3upload(MultipartFile file1) throws IOException{
		String filename  = file1.getOriginalFilename();//a.mp3
		String path = "/Users/jungmin/Desktop/kdt-venture/workspace/AI/naverai_springboot/ai_images/";
		File savefile = new File(path + filename);
		file1.transferTo(savefile);
		return "잘 받았습니다";
		 
	}
	@RequestMapping("/chatbotstt")
	@ResponseBody
	public String chatbotstt(String filename){// a.mp3
		String text = sttservice.test(filename);// 서비스클래스내부 경로+...--> 네이버stt서비스호출
		return text;
	}
	// 1.filename 요청파라미터 값을 전달받아서 
	// 2.ChatbotSTTService test 전달한다
	// 3.값을 리턴받는다
	// 요청했던 뷰로 3번을 리턴한다
	
	// 피자주문 서비스 (ajax)
	@RequestMapping("/pizza")
	@ResponseBody
	public String pizza(String kind, String size, String phonenumber) {

		int pay = 0;
		
		System.out.println("컨트롤러 호출");
		// 원래는 PizzaServiceImpl에 있어야 하는 내용.
		String menu[] = {"컴비네이션피자", "파인애플피자", "고구마피자"}; // @{피자종류} 엔터티 
		int price[] = {10000, 9000, 15000};
		// 1. kind가 메뉴중 하나이면 일치하는 인덱스를 찾아, price 배열에서 값 가져오기.
		for(int i = 0; i < menu.length; i++) {
			if(menu[i].equals(kind)) {
				if(size.equals("라지")) {
					pay = price[i] + 5000;					
				}
				else if(size.equals("미듐")) {
					pay = price[i] + 2500;					
				}
				else {
					pay = price[i];					
				}
				
			}
		}
		
		// 2. 사이즈: 라지(1번 결과 + 5000), 미듐:(1번 결과 + 2500), 스몰: 1번결과
		// 3. "총 xxx원을 지불하셔야 합니다. 010-xxx-xxxx 로 안내드립니다" 리턴
		
		
		
		return "총 " + pay + "원을 지불하셔야 합니다." + phonenumber +" 로 안내드립니다";
	}
	
}



