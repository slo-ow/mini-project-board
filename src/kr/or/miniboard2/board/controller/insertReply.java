package kr.or.miniboard2.board.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import kr.or.miniboard2.board.service.BoardService;
import kr.or.miniboard2.board.service.BoardServiceImpl;
import kr.or.miniboard2.board.vo.BoardVO;

/**
 * Servlet implementation class insertReply
 */
@WebServlet("/insertReply")
public class insertReply extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// 댓글입력처리 컨트롤러
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html;charset=UTF-8");
		// 댓글,댓댓글 구분자
		String reply_ck = req.getParameter("addReply2");
		// IP주소
		String ip = req.getRemoteAddr();
		
		BoardVO vo = new BoardVO();
		
		//IP는 별도로 넣어준다
		vo.setIp(ip);
		
		try {
			BeanUtils.populate(vo, req.getParameterMap());
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		
		//서비스 호출
		BoardService service = BoardServiceImpl.getInstance();
		
		//부모글 (원본글에 각각 +1씩 증가시켜준다)
		int seq = vo.getSeq() + 1; //들여쓰기(글깊이)
		
		//DB에 같은 그룹번호안에서 SEQ(글순서)보다 크거나 같은값이 있으면
		//DB의 SEQ(글순서)값을 수정하기 위해서
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("grp",vo.getGrp());
		map.put("seq",seq);
		
		service.updateSEQ(map);
		vo.setSeq(seq);
		
		System.out.println("******************************* insertReply.java *******************************");
		System.out.println("댓글제목   : "+vo.getTitle());
		System.out.println("댓글내용   : "+vo.getContent());
		System.out.println("댓글작성자 : "+vo.getWriter());
		System.out.println("글번호확인 : "+vo.getIdx());
		System.out.println("상위글번호 : "+vo.getPidx());
		System.out.println("게시글구분 : "+vo.getGubun());
		System.out.println("게시글그룹 : "+vo.getGrp());
		System.out.println("게시글순서 : "+vo.getSeq());
		System.out.println("댓글구분자 : "+reply_ck);
		System.out.println("작성자 IP  : "+vo.getIp());
		System.out.println("******************************* insertReply.java *******************************\n");
		
		
		if(reply_ck.equals("1")){
			//일반댓글 작성
			System.out.println("▶▶▶▶ 일반글댓글 ◀◀◀◀");
			
		}else if(reply_ck.equals("2")){			
			//댓글의 댓글 작성
			System.out.println("▶▶▶▶ 댓글의댓글 ◀◀◀◀");
			
		}
		
		int result = service.insertReply(vo);
		
		
		/* BoardView.jsp 에서 비동기로 요청하기때문에 별도의 페이지 이동은 하지않는다. */
	}

}
