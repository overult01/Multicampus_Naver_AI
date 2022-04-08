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
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;

import org.springframework.stereotype.Service;

import basic.naver.api.NaverService;

@Service("ttsservice")
public class TTSServiceImpl implements NaverService {

	@Override
	public String test(String textfile) {
		return test(textfile, "jinho");
	}
	
	public String test(String textfile, String speaker) {
		String tempname = "";
		
		 String clientId = "tf9vrk4ekg";//애플리케이션 클라이언트 아이디값";
	     String clientSecret = "lQSJjr9OHAIiKhXTtMjY3Vbcib4E2lmyonXWG4oz";//애플리케이션 클라이언트 시크릿값";
	     try {
	         String text = URLEncoder.encode("좋은 아침입니다. 음성을 텍스트로 바꾸는 AI서비스 예시입니다.", "UTF-8"); // 텍스트 파일 
	         // textfile 내용으로 대체
	         String totaltextfile = "/Users/jungmin/Desktop/kdt-venture/workspace/AI/naverai_springboot/ai_images/"+ textfile; 
	         
	         
	         // text파일을 넘기기 
	         FileReader fr = new FileReader(totaltextfile);
//	         fr.read(); // 한글자씩 읽어올 때
	         Scanner scanner = new Scanner(fr); // 한 라인 전체 읽기 
	         while (scanner.hasNextLine() == true) {
	        	 text = "";
	        	 text += scanner.nextLine(); // 읽어오기 
			}

//	         BufferedReader reader = new BufferedReader(
//	        		 new InputStreamReader(new FileInputStream(totaltextfile), "UTF-8")
//	        		 );


	         System.out.println(text); // 확인
	         
	         text = URLEncoder.encode(text, "utf-8");
	         
	         String apiURL = "https://naveropenapi.apigw.ntruss.com/tts-premium/v1/tts";
	         URL url = new URL(apiURL);
	         HttpURLConnection con = (HttpURLConnection)url.openConnection();
	         con.setRequestMethod("POST");
	         con.setRequestProperty("X-NCP-APIGW-API-KEY-ID", clientId);
	         con.setRequestProperty("X-NCP-APIGW-API-KEY", clientSecret);
	         
	         // post request
	         
	         // speaker 지정 가능
	         String postParams = 
	        		 "speaker=" + speaker +"&volume=0&speed=0&pitch=0&format=mp3&text=" + text;

	         con.setDoOutput(true);
	         DataOutputStream wr = new DataOutputStream(con.getOutputStream());
	         wr.writeBytes(postParams);
	         wr.flush();
	         wr.close();
	         int responseCode = con.getResponseCode();
	         BufferedReader br;
	         if(responseCode==200) { // 정상 호출
	             InputStream is = con.getInputStream();
	             int read = 0;
	             byte[] bytes = new byte[1024];

	             // 현재 시작으로 mp3파일 생성, ai_images 폴더 안에 저장 
	             SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd_HHmmss");
	             tempname = sf.format(new Date());
	             File f = new File( "/Users/jungmin/Desktop/kdt-venture/workspace/AI/naverai_springboot/ai_images/" + tempname + ".mp3"); // tts 서비스는 mp3파일로 결과가 온다(json말고)
	             f.createNewFile();
	             OutputStream outputStream = new FileOutputStream(f);
	             while ((read =is.read(bytes)) != -1) {
	                 outputStream.write(bytes, 0, read);
	             }
	             is.close();
	         } else {  // 오류 발생
	             br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	             String inputLine;
	             StringBuffer response = new StringBuffer();
	             while ((inputLine = br.readLine()) != null) {
	                 response.append(inputLine);
	             }
	             br.close();
	             System.out.println(response.toString());
	         }
	     } catch (Exception e) {
	         System.out.println(e);
	     }

		return tempname + ".mp3";
	}
	
	

}
