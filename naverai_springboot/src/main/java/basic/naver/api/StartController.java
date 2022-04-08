package basic.naver.api;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class StartController {

	@RequestMapping("/") // http://localhost:8081/
	public String start() {
		return "start";
	}
}
