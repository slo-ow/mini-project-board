package kr.or.miniboard2.common.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import kr.or.miniboard2.common.sms.SendSMS;

/**
 * Servlet implementation class sendSMS
 */
@WebServlet("/sendSMS")
public class sendSMS extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// 문자메세지 인증번호 전송 컨트롤러
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		//페이지인코딩
		req.setCharacterEncoding("UTF-8");
		
		//JSON 형태로 응답해주기위한 ContentType
		res.setContentType("text/plain;charset=utf-8");
		
		//PrintWriter객체생성
		PrintWriter out = res.getWriter();
		
		//인증요청한 클라이언트의 휴대번호
		String phone = req.getParameter("pnum");
		
		//SMS객체 생성
		SendSMS sms = new SendSMS();
		//생성자로 요청받은 번호를 넘겨주고 랜덤숫자 6자리를 리턴받는다.
		String number = sms.SendSMS(phone);
		
		System.out.println("********************* sendSMS.controller *********************");
		System.out.println(phone  + " : 인증요청 휴대번호 확인");
		System.out.println(number + " : 생성된 랜덤 인증번호");
		System.out.println("********************* sendSMS.controller *********************");
		
		/* Join.jsp 에서 비동기 요청처리를 했기때문에 페이지를 이동시키지 않는다. */
		
		//GSON선언
		Gson gson = new Gson();		
		//JsonObject선언
		JsonObject obj = new JsonObject();
		obj.addProperty("number", number);
		String getValue = gson.toJson(obj);
		System.out.println(getValue + " JSON파싱 확인");
		
		//최종적으로 Join.jsp 페이지에 JSON형태의 값을 전달해주기위한 작업
		out.print(getValue);
		
	}	
}
