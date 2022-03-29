package sound.stt_csr;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.springframework.stereotype.Service;

import basic.naver.api.NaverService;
@Service("csrservice")
public class CSRServiceImpl implements NaverService {

	@Override
	public String test(String image) {
		return test(image, "Kor"); // 사용자가 언어 선택 안할 경우 자동으로 한국어로 설정
	}

	// 오버로딩 
	// 오버라이딩이 아니다. 선언부(매개변수)가 달라지기 떄문.
	public String test(String image, String lang) {
		StringBuffer response = null;
		
        String clientId = "dkzjowr572";//애플리케이션 클라이언트 아이디값";
        String clientSecret = "VpocjvwmKWrmB8AXtRlh4eX2QzPWDmFaIuNCABra";//애플리케이션 클라이언트 시크릿값";

        try {
            String imgFile = "/Users/jungmin/Desktop/kdt-venture/workspace/AI/naverai_springboot/ai_images/" + image;
            File voiceFile = new File(imgFile);

            String language = lang;        // 언어 코드 ( Kor, Jpn, Eng, Chn )
            String apiURL = "https://naveropenapi.apigw.ntruss.com/recog/v1/stt?lang=" + language;
            URL url = new URL(apiURL);

            HttpURLConnection conn = (HttpURLConnection)url.openConnection();
            conn.setUseCaches(false);
            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setRequestProperty("Content-Type", "application/octet-stream");
            conn.setRequestProperty("X-NCP-APIGW-API-KEY-ID", clientId);
            conn.setRequestProperty("X-NCP-APIGW-API-KEY", clientSecret);

            OutputStream outputStream = conn.getOutputStream();
            FileInputStream inputStream = new FileInputStream(voiceFile);
            byte[] buffer = new byte[4096];
            int bytesRead = -1;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
            outputStream.flush();
            inputStream.close();
            BufferedReader br = null;
            int responseCode = conn.getResponseCode();
            if(responseCode == 200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            } else {  // 오류 발생
                System.out.println("error!!!!!!! responseCode= " + responseCode);
                br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            }
            String inputLine;

            if(br != null) {
                response = new StringBuffer();
                while ((inputLine = br.readLine()) != null) {
                    response.append(inputLine);
                }
                br.close();
                System.out.println(response.toString());
            } else {
                System.out.println("error !!!");
            }
        } catch (Exception e) {
            System.out.println(e);
        }

		return response.toString();
	}

	
}
