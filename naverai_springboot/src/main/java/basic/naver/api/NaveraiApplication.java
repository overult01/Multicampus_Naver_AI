package basic.naver.api;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

import chatbot.ChatbotController;
import image.cfr_celebrity_face.FaceController;
import image.objectdetection.ObjectDectionController;
import image.pose.PoseController;
import ocr.OCRController;
import sound.stt_csr.CSRController;
import voice.tts.TTSController;
import voice.tts.test.MapController;


@SpringBootApplication
//현재 패키지 다른 설정 기본 인식
@ComponentScan
//다른 패키지 설정 인식
@ComponentScan(basePackageClasses = FaceController.class)
@ComponentScan(basePackageClasses = ObjectDectionController.class)
@ComponentScan(basePackageClasses = PoseController.class)
@ComponentScan(basePackageClasses = CSRController.class)
@ComponentScan(basePackageClasses = TTSController.class)
@ComponentScan(basePackageClasses = MapController.class)
@ComponentScan(basePackageClasses = OCRController.class)
@ComponentScan(basePackageClasses = ChatbotController.class)
public class NaveraiApplication {

	public static void main(String[] args) {
		SpringApplication.run(NaveraiApplication.class, args);
	}

}
