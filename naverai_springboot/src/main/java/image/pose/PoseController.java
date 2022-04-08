package image.pose;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import basic.naver.api.NaverService;

@Controller
public class PoseController {

	@Autowired
	@Qualifier("poseservice")
	NaverService service;
	
	@RequestMapping("/poseinput")
	public ModelAndView poseinput() {
		File f = new File("/Users/jungmin/Desktop/kdt-venture/workspace/AI/naverai_springboot/ai_images"); // 이미지가 들어있는 폴더
		String[] filelist = f.list();
		ModelAndView mv = new ModelAndView();
		mv.setViewName("pose/input");
		mv.addObject("filelist", filelist);
		return mv;
	}
	
	@RequestMapping("/poseresult")
	public ModelAndView poseresult(String image) { // 파라미터를 뷰에서 쓰려면 ${param.image}로 사용.
		String json = service.test(image);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("pose/poseresult_oneperson");
		mv.addObject("result", json);
		return mv;
	}
	
}
