package kr.or.miniboard2.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.miniboard2.board.service.BoardService;
import kr.or.miniboard2.board.service.BoardServiceImpl;
import kr.or.miniboard2.file.service.FileInfoService;
import kr.or.miniboard2.file.service.FileInfoServiceImpl;
import kr.or.miniboard2.file.vo.FileInfoVo;

/**
 * Servlet implementation class deleteboard
 */
@WebServlet("/deleteboard")
public class deleteboard extends HttpServlet {
	private static final long serialVersionUID = 1L;
          
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// 게시글삭제 (해당 게시글 파일삭제까지같이)
		
		System.out.println("deleteboard controller 호출");
		
	 	String root = "/upload/";
        ServletContext sc = getServletContext();
        String fileRoute = sc.getRealPath(root);
        
		int no = Integer.parseInt(req.getParameter("bno"));
		System.out.println("삭제 게시물 번호 : "+no);
		
		 //파일서비스객체 호출
		 FileInfoService service = FileInfoServiceImpl.getInstance();
		 //게시판서비스객체 호출
		 BoardService bservice = BoardServiceImpl.getInstance();
		 
		 List<FileInfoVo> list = service.selectFileInfo(no); //해당글의 첨부파일 list를 가져옴
		 
		 //삭제할 파일이름
		 String filename = "";
		 
		 //파일삭제
		 for(FileInfoVo x : list){
			 filename = x.getFilename();
			 File f = new File(fileRoute+"/"+filename);
			 if(f.exists()){ //파일이 존재한다면
				 f.delete();
			 }
		 }
		 
		 //게시글 삭제
		 int result = bservice.deleteBoard(no);
		 if(result > 0){
			 System.out.println("******************************* 게시글 삭제완료 *******************************");
		 }else{
			 System.out.println("******************************* 게시글 삭제실패 *******************************");
		 }
		 
		 /* BoardView.jsp 에서 비동기방식으로 요청하기때문에 별도의 페이지 이동은 없음 */
	}

}
