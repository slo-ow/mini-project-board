package kr.or.miniboard2.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.miniboard2.board.service.BoardService;
import kr.or.miniboard2.board.service.BoardServiceImpl;

/**
 * Servlet implementation class deleteReply
 */
@WebServlet("/deleteReply")
public class deleteReply extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// 댓글삭제 컨트롤러
   		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html;charset=UTF-8");
   		
		String idx = req.getParameter("delNum");
		
		BoardService service = BoardServiceImpl.getInstance();
		
		System.out.println("******************************* deleteReply.java *******************************");
		System.out.println("삭제댓글 글번호 : " + idx);
		System.out.println("******************************* deleteReply.java *******************************");
		
		service.DeleteReply(idx);
		
		/* BoardView.jsp 비동기요청 페이지 이동 없음 */
	}

}
