package kr.or.miniboard2.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.miniboard2.board.service.BoardService;
import kr.or.miniboard2.board.service.BoardServiceImpl;
import kr.or.miniboard2.board.vo.BoardVO;

/**
 * Servlet implementation class modifyboard
 */
@WebServlet("/modifyboard")
public class modifyboard extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// 게시글 수정 컨트롤러
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html;charset=UTF-8");
		
		String title = req.getParameter("uptitle");
		String content = req.getParameter("upcontent");
		int idx = Integer.parseInt(req.getParameter("no"));
		
		BoardVO vo = new BoardVO();
		vo.setIdx(idx);
		vo.setTitle(title);
		vo.setContent(content);
		
		System.out.println("******************************* modifyboard.java *******************************");
		System.out.println("수정 글번호 : " + idx);
		System.out.println("수정 글제목 : " + title);
		System.out.println("수정 글내용 : " + content);
		System.out.println("******************************* modifyboard.java *******************************");
		
		BoardService service = BoardServiceImpl.getInstance();
		
		int result = service.updateBoard(vo);
		
		if(result > 0){
			System.out.println("******************************* modifyboard.java *******************************");
			System.out.println("\t게시글 수정결과 : 성공" );
			System.out.println("******************************* modifyboard.java *******************************");
		}else{
			System.out.println("******************************* modifyboard.java *******************************");
			System.out.println("\t게시글 수정결과 : 실패" );
			System.out.println("******************************* modifyboard.java *******************************");
		}
		
		/* BoardView.jsp 비동기 요청 , 페이지 이동처리 따로 존재하지 않음 */
	}

}
