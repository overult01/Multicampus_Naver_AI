package voice.tts;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import basic.naver.api.NaverService;

@Controller
public class TTSController {

	@Autowired
	@Qualifier("ttsservice")
	TTSServiceImpl service;
	
	@RequestMapping("/ttsinput")
	public ModelAndView ttsinput(){
		// tts서비스는 텍스트를 받아서 mp3로 변환
		// 파일리스트-> 뷰(txt파일만 선택가능, 음색, 언어)
		// 파일 선택 -> ttsservice -> txt파일의 텍스트추출 -> mp3변환
		File f = new File("/Users/jungmin/Desktop/kdt-venture/workspace/AI/naverai_springboot/ai_images"); // 이미지가 들어있는 폴더
		// 파일 이름을 . 기준으로 분리 
		String[] filelist = f.list();

		ModelAndView mv = new ModelAndView();
		mv.setViewName("tts/input");
		mv.addObject("filelist", filelist);
		return mv;
	}
	
	@RequestMapping("/ttsresult") // ttsresult?speaker=xx&text=파일명
	public ModelAndView ttsresult(String speaker, String textfile){
		String mp3filename = service.test(textfile, speaker);
		ModelAndView mv = new ModelAndView();
		mv.addObject("result", mp3filename);
		mv.setViewName("tts/result");
		return mv;
	}
	
}
