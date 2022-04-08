package voice.tts.test;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.tomcat.jni.Time;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import voice.tts.TTSServiceImpl;

@Controller
public class MapController {

	@Autowired
	@Qualifier("mapservice")
	MapServiceImpl service;
	
	@Autowired
	@Qualifier("ttsservice")
	TTSServiceImpl ttsservice;
	
	@RequestMapping("/myinput")
	public ModelAndView myinput() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("tts_test/input");
		return mv;
	}
	
	// 대화버튼 눌렀을 때 
	@RequestMapping("/myoutput")
	public ModelAndView myoutput(String question) throws IOException, InterruptedException {
		ModelAndView mv = new ModelAndView();
		
		// 답변
		String response = service.test(question);
		
		// txt 파일로 생성
		// 현재 날짜/ 시간
		Date now = new Date();
		// 포맷팅 정의
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd_HH_mm_ss");
		String formatedNow = formatter.format(now);

        String savePath = "/Users/jungmin/Desktop/kdt-venture/workspace/AI/naverai_springboot/ai_images/";

		FileWriter fw = new FileWriter(savePath+formatedNow + ".txt", false); // false: 덮어쓰겠다. true: 추가하겠다 
        fw.write(response); // 텍스트로 변환된 ai결과가 들어간다.
        fw.close();
        
        // 한글 깨짐 문제 때문에.
//        Writer outFile = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(savePath+formatedNow + ".txt"), "utf-8"));
//        outFile.write(response);
//        outFile.close();
        
		Thread.sleep(1000);
		
		// 파일을 TTSServiceImpl로 전달하여 실행 내용을 리턴받는다.
		String mp3file = ttsservice.test(formatedNow + ".txt");
		
		// 모델 전달
		mv.addObject("question", question);
		mv.addObject("response", response);
		mv.addObject("mp3file", mp3file);

		mv.setViewName("tts_test/result");
		return mv;		
	}
	
}
