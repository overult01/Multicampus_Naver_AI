package sound.stt_csr;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import basic.naver.api.NaverService;

@Controller
public class CSRController {

	@Autowired
	@Qualifier("csrservice")
	CSRServiceImpl service;
	
	@RequestMapping("/csrinput")
	public ModelAndView csrinput() {
		File f = new File("/Users/jungmin/Desktop/kdt-venture/workspace/AI/naverai_springboot/ai_images"); // 이미지가 들어있는 폴더
		// 파일 이름을 . 기준으로 분리 
		String[] filelist = f.list();

		ModelAndView mv = new ModelAndView();
		mv.setViewName("csr/input");
		mv.addObject("filelist", filelist);
		return mv;
	}
	
	@RequestMapping("/csrresult")
	public ModelAndView csrresult(String lang, String image) throws IOException { // 파라미터를 뷰에서 쓰려면 ${param.image}로 사용.
		
		String json = "";
		
		if(lang == null) {
			json = service.test(image);
		}
		else {
			json = service.test(image, lang);
		}
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("csr/result");
		mv.addObject("result", json);
		
		// 변환된 텍스트를 txt파일로 저장 
		JSONObject obj = new JSONObject(json);
		String text = (String)obj.get("text"); // get만 사용하면 Object타입 리턴. 따라서 형변환 필요
		/* 파일명은 현재 시각(년(4)월일시분초) 로 text변수값 저장 
		 * FileWriter
		 * SimpleDateFormat
		 * java.util.Date
		 * */
		
		// 현재 날짜/ 시간
		Date now = new Date();

		// 포맷팅 정의
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd_HH_mm_ss");
		String formatedNow = formatter.format(now);

        String savePath = "/Users/jungmin/Desktop/kdt-venture/workspace/AI/naverai_springboot/ai_images/";

		FileWriter fw = new FileWriter(savePath+formatedNow + ".txt", false); // false: 덮어쓰겠다. true: 추가하겠다 
		fw.write(text); // 텍스트로 변환된 ai결과가 들어간다.
		fw.close();
		
		return mv;
	}
	
}
