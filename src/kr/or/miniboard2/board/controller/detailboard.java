package kr.or.miniboard2.board.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import kr.or.miniboard2.board.service.BoardService;
import kr.or.miniboard2.board.service.BoardServiceImpl;
import kr.or.miniboard2.board.vo.BoardVO;
import kr.or.miniboard2.common.paging.PagingUtil;

/**
 * Servlet implementation class detailboard
 */
@WebServlet("/detailboard")
public class detailboard extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	// 게시글 상세보기 컨트롤러
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		System.out.println("detailboard controller 호출");
		//페이지구분번호
		String gubun = req.getParameter("gubun");
		//글번호
		int idx = Integer.parseInt(req.getParameter("idx"));
		//페이지번호
		int page = Integer.parseInt(req.getParameter("page"));
		
		System.out.println("******************************* detailboard.java *******************************");
		System.out.println(gubun + " : 페이지 구분확인 || [1:공지사항][2:자유게시판]");
		System.out.println(idx +   " : 상세보기 글번호확인");
		System.out.println(page +  " : 상세보기 페이지번호확인");
		System.out.println("******************************* detailboard.java *******************************");
		
		//인코딩
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html;charset=utf-8");
		
		
		//서비스호출
		BoardService service = BoardServiceImpl.getInstance();
		//게시글 상세정보 가져오기
		BoardVO vo = service.detailBoard(idx);
		//게시글 조회수 증가시키기
		service.updateView(idx);
		//댓글 리스트 가져오기
		List<BoardVO> list = service.getReplylist(idx);
			
		//${v}
		req.setAttribute("v", vo);
		req.setAttribute("gubun", gubun);
		req.setAttribute("page", page);
		req.setAttribute("reply", list);
		
		System.out.println("******************************* BoardView.jsp로 페이지이동 *******************************");
		
		RequestDispatcher disp = 
				req.getRequestDispatcher("/index.jsp?contentPage=board/BoardView.jsp?Pages="+gubun+"&?page="+page);
		disp.forward(req,res);
	}

}
