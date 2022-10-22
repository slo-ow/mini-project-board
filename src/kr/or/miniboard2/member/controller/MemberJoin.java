package kr.or.miniboard2.member.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import kr.or.miniboard2.member.service.MemberService;
import kr.or.miniboard2.member.service.MemberServiceImpl;
import kr.or.miniboard2.member.vo.MemberVo;

/**
 * Servlet implementation class MemberJoin
 */
@WebServlet("/MemberJoin")
public class MemberJoin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	// 회원가입 컨트롤러
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		//페이지인코딩
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html;charset=utf-8");
		
		//회원가입 요청한 IP주소
		String ip = req.getRemoteAddr();
		
		MemberVo vo = new MemberVo();
		
		try {
			BeanUtils.populate(vo, req.getParameterMap());
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		
		System.out.println("********************* MemberJoin.controller *********************");
		System.out.println(vo.getMem_id()    +"\t : 아이디");
		System.out.println(vo.getMem_name()  +"\t : 이름");
		System.out.println(vo.getMem_pass()  +"\t : 패스워드");
		System.out.println(vo.getMem_sex()   +"\t : 성별");
		System.out.println(vo.getMem_phone() +"\t : 휴대전화번호");
		System.out.println(vo.getMem_mail()  +"\t : 이메일");
		System.out.println(vo.getMem_bir()   +"\t : 생년월일");
		System.out.println(vo.getMem_addr1() +"\t : 우편번호");
		System.out.println(vo.getMem_addr2() +"\t : 상세주소");
		System.out.println("********************* MemberJoin.controller *********************");
		System.out.println(ip +" : 회원가입요청 IP 주소");
		
		MemberService service = MemberServiceImpl.getService();
		String get = service.insertMember(vo);
		System.out.println(get + ": 결과 확인");
		
		res.sendRedirect("index.jsp");
		
	}

}
