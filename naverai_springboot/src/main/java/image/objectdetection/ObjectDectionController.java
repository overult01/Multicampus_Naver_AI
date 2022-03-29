package image.objectdetection;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ObjectDectionController {

	@Autowired
	@Qualifier("objectdetectionservice")
	ObjectDectionServiceImpl service; // NaverService 인터페이스 타입으로 지정해도 무방 
	
	@RequestMapping("/objectdetectioninput")
	public ModelAndView objectdetectioninput() {
		File f = new File("/Users/jungmin/Desktop/kdt-venture/workspace/AI/naverai_springboot/ai_images"); // 이미지가 들어있는 폴더
		String[] filelist = f.list();
		ModelAndView mv = new ModelAndView();
		mv.setViewName("objectdetection/input");
		mv.addObject("filelist", filelist);
		return mv;
	}
	
	@RequestMapping("/objectdetectionresult")
	public ModelAndView objectdetectionresult(String image) { // 파라미터를 뷰에서 쓰려면 ${param.image}로 사용.
		String json = service.test(image);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("objectdetection/result");
		mv.addObject("result", json);
		return mv;
	}
	
}
