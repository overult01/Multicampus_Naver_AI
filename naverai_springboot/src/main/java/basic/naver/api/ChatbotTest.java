package basic.naver.api;

import java.util.Iterator;

public class ChatbotTest {

	public static void main(String[] args) {

		String reply = "고구마피자, 스몰 주문하셨습니다. 주문자님의 폰번호 01011212487로 안내드립니다.";
		
		if (reply.contains("주문자")) {
			String[] result = reply.split(" ");
			for (int i = 0; i < result.length; i++) {
				System.out.println(result[i]);
			}
			
			String kind = result[0].substring(0, result[0].length()-1);
			String size = result[1];
			String phonenumber = result[5].substring(0, result[5].length()-1);
			
			System.out.println(kind);
			System.out.println(size);
			System.out.println(phonenumber);
		}
		
	}

}
