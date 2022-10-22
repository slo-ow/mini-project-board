package kr.or.miniboard2.file.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.miniboard2.file.service.FileInfoService;
import kr.or.miniboard2.file.service.FileInfoServiceImpl;

/**
 * Servlet implementation class filedown
 */
@WebServlet("/filedown")
public class filedown extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	// 파일 다운로드 컨트롤러
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		System.out.println("filedown controller 호출");
		
		req.setCharacterEncoding("UTF-8");
		String filename = req.getParameter("filename");
		System.out.println(filename + " || 파일이름 확인");
		//////////////////////////////////////////////////////////////////////////////////////////////////////////
				
		//Service객체 호출
		FileInfoService service = FileInfoServiceImpl.getInstance();
		
		//Service 호출, 넘겨받은 filename을 매개변수로 넘겨주면서 DB에 저장되어있는 원본파일명을 찾아옴.
		//넘겨받은 filname 은 현재날짜+밀리세컨드 단위로 변경되어서 저장되어있다.
		//변경되어있는 filename의 originalname을 DB에서 찾아서 name변수에 저장시키고 그것을 file객체의 변수에 저장시킨다.
		String name = service.selectFileName(filename);		
		System.out.println("[쿼리결과값] : "+ name + " || 원본파일명 확인");
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		//파일이 저장되어있는 디렉토리로부터 넘겨받은 filename과 같은 파일을 찾는다.
		String upfile = "/upload/";
	    String root = req.getSession().getServletContext().getRealPath(upfile);
		File file = new File(root +"/"+ filename);
		
		//다운로드를 위한 mimetype application / octet-stream 
		String type = this.getServletContext().getMimeType(file.toString());
		if(type==null){
			res.setContentType("application/octet-stream");
		}
		
		//다운로드로 내려받을때 파일명을 원본파일명으로 다시 변환해준다.
		String downName = null;
		downName  = new String(name.getBytes("UTF-8"),"8859_1");
		System.out.println("downName = "+downName);
		
		//다운로드를 위한 header 설정
		res.setHeader("Content-Disposition", "attachment;filename=\"" + downName + "\";");
			//								;filename=\"aaa.txt"
		//FileInputStream 으로 저장폴더로부터 file객체를 읽어온다.
		FileInputStream fin = new FileInputStream(file);
		//웹브라우저에 출력해줘야하기때문에 FileOutputStream 을 사용하지않고
		//ServletOutputStream 으로 출력한다.
		ServletOutputStream sout = res.getOutputStream();
		
		// 1024 == 1KB		
		byte byte4K[] = new byte[4096]; //4096 == 4KB 씩 잘라서 보냄.
		
		int out = 0;
		while(true){
		 out = (fin.read(byte4K,0,byte4K.length));
		 if(out == -1) break;			
         sout.write(byte4K,0,out);         
		}
		
		sout.flush(); //flush : 밀어넣기
		sout.close(); //닫기
		fin.close();  //닫기
		
		System.out.println("******************************* File DownLoad 완료 페이지이동 없음 *******************************");
	}

}
