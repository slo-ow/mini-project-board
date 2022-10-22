package kr.or.miniboard2.board.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.miniboard2.board.service.BoardService;
import kr.or.miniboard2.board.service.BoardServiceImpl;
import kr.or.miniboard2.board.vo.BoardVO;
import kr.or.miniboard2.common.paging.PagingUtil;

/**
 * Servlet implementation class selectboard
 */
@WebServlet("/selectboard")
public class selectboard extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	// 게시판 select 요청 컨트롤러
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		System.out.println("selectboard controller 요청");
		
		//인코딩
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html;charset=utf-8");
		//게시판 구분자를 넘겨받아서 scope 저장
		String gubun = req.getParameter("gubun");
		req.setAttribute("gubun", gubun);
		
		////////////////////////////////////////////////페이지 처리///////////////////////////////////////////////////
		//출력할 페이지와 글 설정 
		int totalCount = 0;   //전체글갯수 
		int perblock = 2;  //한블럭에 3개의 페이지수를 묶는다 
		int perlist = 5; //한페이지에 출력할 글갯수
		
		//현재페이지
		int currentPage =1;
		
		String spage = req.getParameter("page");
		System.out.println(spage + " : 페이지번호 확인");
		
		if(spage != null){
			currentPage = Integer.parseInt(spage);
			
		}else{
			currentPage = 1;
		} 
		
		//검색문자 
		String stype = req.getParameter("stype");
		String sword = req.getParameter("sword");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("stype", stype);
		map.put("sword", sword);
		map.put("gubun_ck", "check");
		map.put("gubun", gubun);
		
		System.out.println(gubun + " : 페이지 구분확인 || [1/공지사항],[2/자유게시판]");
		System.out.println("||||||||stype = " + stype + "||||||||");		
		System.out.println("||||||||sword = " + sword + "||||||||");		
		
		//서비스 객체생성
		BoardService service = BoardServiceImpl.getInstance();
		
		//전체글갯수 구하기 
		totalCount  = service.listCount(map); //stype, sword가 필요
				
		/////////////////////////////////
		//PagingUtil 클래스를 이용 
		//생성자에 currentPage,totalCount, perblock, perlist, request
		//값을 넘겨서 totalPage startPage, endPage, start, end,
		//pagenavigation 을 구한다 
		//
		////////////////////////////////
		
		PagingUtil  pg =
				new PagingUtil(currentPage, totalCount, perblock, perlist, req);
		
		//출력할 글 목록 가져오기  - start, end, stype, sword 가 필요 
		map.put("start", pg.getStart());
		map.put("end", pg.getEnd());
		
		List<BoardVO> list = service.listAll(map);
		
		//출력할 값을 가지고(request저장) - java
		//view 페이지(voardlist.jsp)로 이동  - jsp 
		
		req.setAttribute("list", list);
		req.setAttribute("pagenavi", pg.getPageHtml());
		req.setAttribute("stype", stype);
		req.setAttribute("sword", sword);
		req.setAttribute("page", currentPage);
		
		System.out.println("******************************* Board.jsp로 페이지이동 *******************************");
		RequestDispatcher disp = 
				req.getRequestDispatcher("/index.jsp?contentPage=board/Board.jsp?gubun="+gubun+"&page="+currentPage+"&stype="+stype+"&sword="+sword);
		disp.forward(req,res);
	}

}
