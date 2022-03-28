package image.cfr_celebrity_face;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import basic.naver.api.NaverService;

@Controller
public class FaceController {
	
	@Autowired
	@Qualifier("faceservice")
	NaverService faceservice;
	
	
	@Autowired	  
	@Qualifier("faceservice2") 
	NaverService faceservice2;
	 
	
	//이미지파일 리스트 보여주는 페이지 뷰
	@RequestMapping("/faceinput")
	public ModelAndView faceinput() {
		File f = new File("/Users/jungmin/Desktop/kdt-venture/workspace/AI/naverai_springboot/ai_images");
		String [] filelist = f.list();
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("filelist", filelist);
		mv.setViewName("cfr_celebrity_face/faceinput_celebrity");
		
		return mv;
	}
	
	@RequestMapping("/faceresult")
	public ModelAndView faceresult(String image) {
		//컨트롤러(요쳥-어떤서비스에 일 결과-어떤 뷰) - 서비스 - 뷰 역할
		String json = faceservice.test(image);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("faceresult", json);
		mv.setViewName("cfr_celebrity_face/faceresult_celebrity");
		return mv;
		
	}
	
	// 얼굴 감지 API
	@RequestMapping("/faceinput2")
	public ModelAndView faceinput2() {
		
		File f = new File("/Users/jungmin/Desktop/kdt-venture/workspace/AI/naverai_springboot/ai_images");
		String [] filelist = f.list();
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("filelist", filelist);
		mv.setViewName("cfr_celebrity_face/faceinput_face");
		
		return mv;
	}
	
	@RequestMapping("/faceresult2")
	public ModelAndView faceresult2(String image) {
		//컨트롤러(요쳥-어떤서비스에 일 결과-어떤 뷰) - 서비스 - 뷰 역할
		String json = faceservice2.test(image);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("faceresult2", json);
		mv.setViewName("cfr_celebrity_face/faceresult_face");
		return mv;
		
	}

	// 얼굴 감지 API+캔버스
	@RequestMapping("/faceinput3")
	public ModelAndView faceinput3() {		
		File f = new File("/Users/jungmin/Desktop/kdt-venture/workspace/AI/naverai_springboot/ai_images");
		String [] filelist = f.list();
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("filelist", filelist);
		mv.setViewName("cfr_celebrity_face/faceinput_face_canvas");
		
		return mv;
	}
	
	//1개 이미지 선택 - 네이버 AI 서버 요청 - 응답 뷰
	@RequestMapping("/faceresult3")
	public ModelAndView faceresult3(String image) {//뷰 ${param.image}  /naverimages/a.jpg
		// 컨트롤러(요청분석 - 어떤 서비스 일 결과 - 어떤 뷰 ) - 서비스 - 뷰 역할
		String json = faceservice2.test(image);// 얼굴 분석 서비스 요청
		ModelAndView mv = new ModelAndView();
		mv.addObject("faceresult3", json);
		//mv.setViewName("faceresult2");
		mv.setViewName("cfr_celebrity_face/faceresult_face_canvas");//캔버스추가
		return mv;
	}
	

}
