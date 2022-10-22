package kr.or.miniboard2.common.sms;

import java.io.*;
/**
 * @author 문성철
 * @version 1.0
 * 문자메세지 발송 클래스  
 * 
 */
public class SendSMS{	
	
	public static String SendSMS(String getNumber)
	{	
		//인증번호요청을위한 랜덤인증번호 6자리 생성후 메세지 전송
		int n1 = (int)(Math.random()*9+1);
		int n2 = (int)(Math.random()*9+1);
		int n3 = (int)(Math.random()*9+1);
		int n4 = (int)(Math.random()*9+1);
		int n5 = (int)(Math.random()*9+1);
		int n6 = (int)(Math.random()*9+1);
		
		//6자리의 숫자이기때문에 자릿수 만큼을 곱해준다
		String random = String.valueOf(((n1*100000)+(n2*10000)+(n3*1000)+(n4*100)+(n5*10)+n6));
	    //String mnumber = getNumber; //회원이 입력한 번호를 받아와서 저장함.
	    //System.out.println(mnumber);

		//SMS sms = new SMS();
/*	    
		sms.appversion("TEST/1.0");
		sms.charset("utf8");
		sms.setuser("icet25", "tjdcjf12"); // coolsms 계정과 패스워드를 입력해주시면되요


		String number[] = new String[1]; // 받을 사람 인원수만큼 		
		number[0] = mnumber; //받을 사람 폰번호


		for( int i = 0 ; i < number.length ; i ++ ) {
			SmsMessagePdu pdu = new SmsMessagePdu();
			pdu.type = "SMS";
			pdu.destinationAddress = number[i];
			pdu.scAddress = "01096702460"	;  // 발신자 번호          
			pdu.text = "누리마블 인증번호 :"+random;	// 보낼 메세지 내용 (랜덤인증번호6자리를 보냄)
			sms.add(pdu);

			try {
				sms.connect();
				sms.send();
				sms.disconnect();
			} catch (IOException e) {
				System.out.println(e.toString());
			}
			sms.printr();
			sms.emptyall();
		}
*/
		return random;

	}

	/*public static void main(String[] args) {
		SendSMS sms = new SendSMS();
	}*/
	
}

