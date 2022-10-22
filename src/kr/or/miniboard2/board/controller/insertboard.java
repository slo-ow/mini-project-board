package kr.or.miniboard2.board.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.miniboard2.board.service.BoardService;
import kr.or.miniboard2.board.service.BoardServiceImpl;

/**
 * Servlet implementation class insertboard
 */
@WebServlet("/insertboard")
public class insertboard extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	// 게시글 작성 + 멀티파일 업로드 컨트롤러
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		System.out.println("insertboard 게시판 호출 : 게시글작성/파일업로드");
		
		// 멀티파일업로드
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html;charset=UTF-8");
		
		BoardService service = BoardServiceImpl.getInstance();
		service.insertBoard(req);
				
		/* Board.jsp 에서 비동기방식 Ajax로 진행하기때문에 별도의 페이지이동은 없다 
		 * 결과적으로 게시글저장 및 멀티파일 업로드 로직은 ServiceImpl 에서 진행함.
		 * */
	}

}
