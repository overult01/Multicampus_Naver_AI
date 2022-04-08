package ocr;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class OCRController {

	@Autowired
	@Qualifier("ocrservice")
	OCRServiceImpl service;
	
	@RequestMapping("/ocrinput")
	public ModelAndView ocrinput(){
		// tts서비스는 텍스트를 받아서 mp3로 변환
		// 파일리스트-> 뷰(txt파일만 선택가능, 음색, 언어)
		// 파일 선택 -> ttsservice -> txt파일의 텍스트추출 -> mp3변환
		File f = new File("/Users/jungmin/Desktop/kdt-venture/workspace/AI/naverai_springboot/ai_images"); // 이미지가 들어있는 폴더
		// 파일 이름을 . 기준으로 분리 
		String[] filelist = f.list();

		ModelAndView mv = new ModelAndView();
		mv.setViewName("ocr/input");
		mv.addObject("filelist", filelist);
		return mv;
	}
	
	@RequestMapping("/ocrresult")
	public ModelAndView ocrresult(String fontfile) {
		String json = service.test(fontfile);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("ocr/result");
		mv.addObject("ocrresult", json);
		return mv;
	}
}
