package kr.or.miniboard2.common.paging;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

public class PagingUtil {
	
	private int currentPage;
	private int totalCount;
	private int perblock;
	private int perlist;
	private int totalPage;
	private int startPage;
	private int endPage;
	private int start;
	private int end;
	private String pageHtml="";
	private int gubun; //게시판 구분자

	//BoardList 서블릿 파일에서 파라미터로 가져온다 
	public PagingUtil(int currentPage, int totalCount, 
			 int perblock, int perlist , HttpServletRequest request){
		this.currentPage = currentPage;
		this.totalCount = totalCount;
		this.perblock = perblock;
		this.perlist  = perlist;
		this.gubun = Integer.parseInt(request.getParameter("gubun"));
		
		//총페이지수 구하기
		totalPage =   (int)( Math.ceil((double)totalCount / perlist));
		if(totalPage == 0) totalPage = 1;
		
		//시작페이지/종료페이지
		//1블럭 [1][2][3] -> 2블럭 [4][5][6]  - 3블럭 [7][8]
		startPage  =  ((currentPage-1) /perblock *perblock) + 1;
		endPage   = startPage + perblock -1;
		if(endPage > totalPage) endPage = totalPage;
		
		//start/end -글번호 
		//1페이지 -> 1~ 5   2페이지 6~10   3페이지 11~15
		start = (currentPage-1) * perlist +1;
		end  = start + perlist  -1;
		if(end > totalCount) end= totalCount;
		
		
		//192.168.207.25/boardpro/BoardList
		//192.168.207.25/boardpro/BoardList?page=3
		//192.168.207.25/boardpro/BoardList?page=2&stype=title&sword=길동
		//192.168.207.25/boardpro/BoardList?stype=name&sword=korea
		//[1][2][3]
		
		//String uri = "index.jsp?contentPage=board/Board.jsp"; //index.jsp?contentPage=board/Board.jsp
		String uri = request.getRequestURI(); //index.jsp?contentPage=board/Board.jsp
				
		System.out.println("******************************* PagingUtil.java *******************************");
		System.out.println(gubun + " : || Pageing gubun 확인");
		System.out.println(uri   + " : || Pageing uri 확인");
		System.out.println("******************************* PagingUtil.java *******************************\n");
		
		Enumeration<String>  param =   request.getParameterNames(); // page,stype,sword
		String queryStr="";
		
		while( param.hasMoreElements()){
			String name = param.nextElement(); //page  / stype  /sword 
		    //해당name속의 값을 꺼낸다
			String value=  request.getParameter(name);//3   title  길동
			
		    if(name.equals("stype") || name.equals("sword")){
		    	queryStr += name  + "=" + value + "&";
		    	//queryStr = stype=title&sword=길동&
		    }
		}  //BoardList?stype=title&sword=길동&page=12121212
		
		// [1][2][3] 다음    이전 [4][5][6] 다음
		
		/*
		    <li><a href='index.jsp?contentPage=board/Board.jsp?Pages='>Prev</a></li>
			<li><a href='index.jsp?contentPage=board/Board.jsp?Pages='>1</a></li>
			<li><a href='index.jsp?contentPage=board/Board.jsp?Pages='>Next</a></li>
		 */
		//이전 링크
		if(startPage > 1) {
			pageHtml = "<li><a href='" + uri + "?" + queryStr + "gubun=" + gubun  + "&page=" + (startPage -1) + "'>Prev</a></li>";
		}
		//페이지링크
		for(int i=startPage; i<=endPage; i++){
			if(currentPage == i){
				pageHtml +="<li><a href='#'><font color='red'>" +  i  + "</font></a></li>";
			}else{
				pageHtml += "<li><a href='" + uri + "?" + queryStr + "gubun=" + gubun  + "&page=" + i +"'>" + i + "</a><li>";
			}
		}
		//다음링크
		if(endPage < totalPage) {
			pageHtml += "<li><a href='" + uri + "?" + queryStr + "gubun=" + gubun  + "&page=" + (endPage + 1) + "'>Next</a></li>";
		}
		
	} //생성자 끝

	public int getCurrentPage() {
		return currentPage;
	}


	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}


	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}


	public int getPerblock() {
		return perblock;
	}



	public void setPerblock(int perblock) {
		this.perblock = perblock;
	}



	public int getPerlist() {
		return perlist;
	}



	public void setPerlist(int perlist) {
		this.perlist = perlist;
	}



	public int getTotalPage() {
		return totalPage;
	}



	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}



	public int getStartPage() {
		return startPage;
	}



	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}



	public int getEndPage() {
		return endPage;
	}



	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}



	public int getStart() {
		return start;
	}



	public void setStart(int start) {
		this.start = start;
	}



	public int getEnd() {
		return end;
	}



	public void setEnd(int end) {
		this.end = end;
	}

	public String getPageHtml() {
		return pageHtml;
	}

	public void setPageHtml(String pageHtml) {
		this.pageHtml = pageHtml;
	}
	
	
		
		
	

}



















