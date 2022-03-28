package basic.naver.api;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

import cfr_celebrity_face.FaceController;
import objectdection.ObjectDectionController;


@SpringBootApplication
//현재 패키지 다른 설정 기본 인식
@ComponentScan
//다른 패키지 설정 인식
@ComponentScan(basePackageClasses = FaceController.class)
@ComponentScan(basePackageClasses = ObjectDectionController.class)
public class NaveraiApplication {

	public static void main(String[] args) {
		SpringApplication.run(NaveraiApplication.class, args);
	}

}
