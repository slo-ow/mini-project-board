package kr.or.miniboard2.common.mail;
 
import java.util.Properties;
 
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
 
/**
 * @author 문성철
 * @version 1.0
 * 
 * 네이버 메일을 이용한 메일발송 클래스
 * */
public class FindNaverMail {
	public static String UserEmail; //사용자 이메일
	public static String UserNumber; //사용자가 요청한 인증번호
	
	/*
	public void FindNaverMail(String email){ //사용자가 이메일로 찾기를했을때 사용자의 메일을 받아옴.
		this.UserEmail = email;
	}
	public String getUserNumber(){ //요청한 인증번호를 반환
		
		return UserNumber;
	}
	public String getUserEmail(){ //사용자 이메일을 반환함
		return UserEmail;
	}*/
	
    public String SendEmail(String usermail) throws MessagingException{ //인증번호요청할때 회원의 email을 받아옴.
    	System.out.println("메일발송 시작");
    	//인증번호요청을위한 랜덤인증번호 6자리 생성후 메세지 전송
		int n1 = (int)(Math.random()*9+1);
		int n2 = (int)(Math.random()*9+1);
		int n3 = (int)(Math.random()*9+1);
		int n4 = (int)(Math.random()*9+1);
		int n5 = (int)(Math.random()*9+1);
		int n6 = (int)(Math.random()*9+1);
		
		//6자리의 숫자이기때문에 자릿수 만큼을 곱해준다
		String random = String.valueOf(((n1*100000)+(n2*10000)+(n3*1000)+(n4*100)+(n5*10)+n6));
	    System.out.println(random);
	    
	    //사용자가 요청한 인증번호
	    UserNumber = random;
	    System.out.println(UserNumber +" ||사용자 요청 인증번호를 UserNumber에 저장");
	    
        // 메일 관련 정보
        String host = "smtp.naver.com";
        final String username = "icet25"; //@naver.com 제외한 아이디만
        final String password = "tjdcjf11"; //본인 메일 비밀번호
        int port=465;
         
        // 메일 내용
        //String recipient = "icet25@naver.com"; 		 // 발송받는 이메일
        String recipient = usermail; 		 // 발송받는 이메일
        String subject = "[Yongmanble] 인증코드";   // 이메일 제목
        String body = "회원님의 인증코드는 : ["+random+"] 입니다.";  // 이메일 내용
         
        Properties props = System.getProperties();
         
         
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.enable", "true");
        props.put("mail.smtp.ssl.trust", host);
          
        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            String un=username;
            String pw=password;
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(un, pw);
            }
        });
        session.setDebug(true); //for debug
          
        Message mimeMessage = new MimeMessage(session);
        mimeMessage.setFrom(new InternetAddress("icet25@naver.com"));
        mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
        mimeMessage.setSubject(subject);
        mimeMessage.setText(body);
        Transport.send(mimeMessage);
        
        return UserNumber;
    }
}