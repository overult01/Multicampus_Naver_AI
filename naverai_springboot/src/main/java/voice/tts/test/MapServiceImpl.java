package voice.tts.test;

import java.util.HashMap;
import org.springframework.stereotype.Service;
import basic.naver.api.NaverService;

// 챗봇 맛보기. 질문에 대한 대답 
@Service("mapservice")
public class MapServiceImpl implements NaverService{

	HashMap<String, String> map = new HashMap<String, String>();

	// 생성자 
	public MapServiceImpl() {
		map.put("이름이 뭐니?", "클로바야");
		map.put("무슨 일을 하니?", "ai 서비스 관련 일을 해");
		map.put("멋진 일을 하는구나", "고마워");
		map.put("난 훌륭한 개발자가 될거야", "넌 할 수 있어");
		map.put("잘자", "내 꿈꿔");
	}
	
	// 필수구현
	@Override
	public String test(String request) {
		String response = map.get(request);
		if(response == null) {
			response = "이해할 수 없는 질문입니다.";
		}
		return response;
	}
	
	// 서비스이면서(스프링부트 실행), 자바 어플리케이션으로도 실행
	public static void main(String args[]) {
		MapServiceImpl service = new MapServiceImpl();
		String response_consol1 = service.test("질문");
		System.out.println(response_consol1);
		
		String response_consol2 = service.test("이름이 뭐니?");
		System.out.println(response_consol2);

	}

}
