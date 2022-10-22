package kr.or.miniboard2.board.service;

import java.io.File;
import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.or.miniboard2.board.dao.BoardDao;
import kr.or.miniboard2.board.dao.BoardDaoImpl;
import kr.or.miniboard2.board.vo.BoardVO;
import kr.or.miniboard2.file.service.FileInfoService;
import kr.or.miniboard2.file.service.FileInfoServiceImpl;
import kr.or.miniboard2.file.vo.FileInfoVo;
import kr.or.miniboard2.member.service.MemberService;
import kr.or.miniboard2.member.service.MemberServiceImpl;
import kr.or.miniboard2.member.vo.MemberVo;

public class BoardServiceImpl implements BoardService{
	
	private static BoardServiceImpl service = null;
	private BoardDao dao;
	
	private BoardServiceImpl(){
		dao = BoardDaoImpl.getInstance();
	};
	
	public static BoardService getInstance(){
		if(service == null){
			service = new BoardServiceImpl();
		}
		return service;
	}
	
	//게시판 조회 + 검색
	@Override
	public List<BoardVO> listAll(Map<String, Object> map) {
		List<BoardVO>  list = null;
		
		try {
			list = dao.listAll(map);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	//전체 글 개수 구하기
	@Override
	public int listCount(Map<String, Object> map) {
		int res =0;
		try {
			res = dao.listCount(map);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}
	
	//게시글 작성 + 멀티파일 업로드
	@Override
	public int insertBoard(HttpServletRequest req) {
		//IP주소
		String ip = req.getRemoteAddr();
		
		//반환값 
		int res = 0;
				
		// 50MB 제한
	    int maxSize  = 1024*1024*50;        
	    System.out.println("업로드 용량제한 확인 : " + maxSize);
	    	  		
	    // 웹서버 컨테이너 경로
	    String upfile = "/upload/";
	    String root = req.getSession().getServletContext().getRealPath(upfile);
	    File dir = new File(root);
	    if(!dir.exists()){
	    	dir.mkdirs();
	    }
	    
	    // 파일 저장 경로
	    //String savePath = "D:\\file";
	 	    	 
	    // DB FILENAME으로 저장할 파일명
	    String newFileName = "";
	    
	    // 파일 원본명
	    String og_name = "";
	    
	    // 임시변경된 파일명
		String save_fname = "";
		
		// 파일 사이즈
		long size = 0L;		    
		
		
	    // 파일명 형식변환 ==> 현재시간 밀리세컨드까지
	    long currentTime = System.currentTimeMillis();  
	    SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMddHHmmss");  
	    
		try {
			MultipartRequest mr = new MultipartRequest(req, root, maxSize, "UTF-8", new DefaultFileRenamePolicy());
			
			int gubun = Integer.parseInt(mr.getParameter("gubun"));
	        String title = mr.getParameter("title");
	        String content = mr.getParameter("content");
	        String writer = mr.getParameter("writer");
	        
	        //멤버서비스 호출
	        MemberService msv = MemberServiceImpl.getService();
	        //멤버정보가져오기
	        MemberVo mvo = msv.selectMember(writer, "");
	        String mail = mvo.getMem_mail();
	        
	        System.out.println("**************************** insertBoard ****************************");
	        System.out.println(gubun);
	        System.out.println(title);
	        System.out.println(content);
	        System.out.println(writer);
	        System.out.println(mail);
	        System.out.println(ip);
	        System.out.println("**************************** insertBoard ****************************");
	        
			BoardVO vo = new BoardVO();
			vo.setGubun(gubun);
			vo.setTitle(title);
			vo.setContent(content);
			vo.setWriter(writer);
			vo.setMail(mail);
			vo.setIp(ip);
			
			//작성한글을 저장하고 글번호(시퀀스) 값을 selectKey로 리턴받는다.
			int num = dao.insertBoard(vo);
			
	
			//파일서비스호출
			FileInfoService fsv = FileInfoServiceImpl.getInstance();
			
			//멀티파일업로드를위해 list 안에 add시켜서 값을 전달
			List<FileInfoVo> list = new ArrayList();
			//멀티파일업로드 insertFileInfo(Map<String, Object> map) 전달을위해 Map선언
			Map<String, Object> map = new HashMap();
					
			int cnt = 0; //files 개수만큼 중복제거를위해 숫자를 붙힘
			
			Enumeration files = mr.getFileNames(); //파일명정보를 배열로 만들다(files에 name들이 담겨있다)
			//여기서 주의할점은 input 타입이 파일인 요소 여러개의 name이 모두 같다면 맨 마지막에 온 파일만 읽게된다.
			//따라서 파일 input의 name을 다르게 주어야하겠다.
			
			while(files.hasMoreElements()){		        
				FileInfoVo ivo = new FileInfoVo(); 
				//  name에 저장되는값은 input type name=""의 값임 
				String name = (String)files.nextElement(); //각각의 파일 name을 String name에 담는다.
				System.out.println(name + " 여러개 넘어오는지 확인");
				String file = mr.getContentType(name); // 파일의 컨텐트타입을 반환한다, 없으면 null을 반환
				String extenstion = ""; // 파일확장자
				
				if(file==null){ //파일이 없다면 null값을 넣어준다.
					og_name = null;
					newFileName = null; 
					size = 0;	
					extenstion = null;
				}else{	//파일이 존재한다면 아래의 로직을 실행
					
					og_name = mr.getOriginalFileName(name); //파일의 원본파일명을 받아옴
					save_fname = mr.getFilesystemName(name); //각각의 파일 name을 통해서 파일의 정보를 얻는다.
					size = mr.getFile(name).length(); //파일 사이즈		    
					extenstion = save_fname.substring(save_fname.lastIndexOf(".")+1);
					// 실제 저장할 파일명(ex : 201703011513130+(1),(2)~~.jpg)
					newFileName = simDf.format(new Date(currentTime)) + cnt +"."+ save_fname.substring(save_fname.lastIndexOf(".")+1);
					
					/*
			        MultipartRequest 를 사용할 경우 파일 이름을 변경 하여 업로드 할 수 없다.
			         이유는 MultipartRequest 생성시 바로 업로드 되기때문이다.
			         그래서 업로드후에 파일명을 변경 하는 방법을 선택 하여야 한다.
				    */
					
					File oldFile = new File(root +"/"+ save_fname);
					File newFile = new File(root +"/"+ newFileName); 
					oldFile.renameTo(newFile); // 저장파일의 파일명 변경
					
					System.out.println(newFile + "\t||\t 저장경로 변경파일명확인");
					System.out.println(name + "\t||\t"+cnt+" 번째 파일");
					System.out.println(save_fname + "\t||\t파일이름(중복검사)");
					System.out.println(newFileName + "\t||\t파일이름(중복제거)");
					System.out.println(og_name + "\t||\t파일이름(원본파일이름)");
					System.out.println(size + "\t||\t파일사이즈");
					System.out.println(extenstion + "\t||\t파일확장자");
					cnt++;
				}
				
				
				ivo.setBno(num); //부모글의 번호로 set시킴 pk == fk 를 찾기위해서
				ivo.setFilename(newFileName); //중복제거를시키고 파일명형식을 변경시킨값을 저장
				ivo.setOriginalname(og_name); //업로드시 원본파일명을 그대로 저장
				ivo.setFilesize(size); // 파일사이즈 저장
				ivo.setExtenstion(extenstion); //파일 확장자명
				
				fsv.insertFileinfo(ivo);
			}
		} catch (Exception e) {			
			e.printStackTrace();
		}
		return res;
		}
	
	//게시글 상세보기
	@Override
	public BoardVO detailBoard(int idx) {
		BoardVO vo = null;
		try {
			vo = dao.detailBoard(idx);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return vo;
	}
	
	//게시글 조회수증가
	@Override
	public void updateView(int idx) {
		try {
			dao.updateView(idx);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//게시글 삭제
	@Override
	public int deleteBoard(int no) {
		int res = 0;
		try {
			res = dao.deleteBoard(no);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}
	
	//게시글 수정
	@Override
	public int updateBoard(BoardVO vo) {
		int res = 0;
		try {
			res = dao.updateBoard(vo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}
	
	//댓글 작성
	@Override
	public int insertReply(BoardVO vo) {
		int res = 0;
		try {
			res = dao.insertReply(vo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}

	//댓글의 글순서(SEQ)증가	
	@Override
	public int updateSEQ(Map<String, Object> map) {
		int res = 0;
		try {
			res = dao.updateSEQ(map);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}

	//댓글 리스트
	@Override
	public List<BoardVO> getReplylist(int idx) {
		List<BoardVO> list = null;
		try {
			list = dao.getReplylist(idx);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	//댓글삭제
	@Override
	public int DeleteReply(String idx) {
		int res = 0;
		try {
			res = dao.DeleteReply(idx);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}

	

}
