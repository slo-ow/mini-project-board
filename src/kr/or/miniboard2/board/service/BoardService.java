package kr.or.miniboard2.board.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.or.miniboard2.board.vo.BoardVO;

public interface BoardService {
	
	//게시판조회 + 검색
	public List<BoardVO> listAll(Map<String, Object> map);
	
	//전체글 개수 구하기
	public int listCount(Map<String, Object> map);
	
	//게시글 작성 + 멀티파일업로드
	public int insertBoard(HttpServletRequest req);
	
	//게시글 상세보기
	public BoardVO detailBoard(int idx);
	
	//게시글 조회수증가
	public void updateView(int idx);
	
	//게시글 삭제
	public int deleteBoard(int no);
	
	//게시글 수정
	public int updateBoard(BoardVO vo);
	
	//댓글 작성
	public int insertReply(BoardVO vo);
	
	//댓글의 글순서(SEQ)증가
	public int updateSEQ(Map<String,Object> map);
	
	//댓글 리스트
	public List<BoardVO> getReplylist(int idx);
	
	//댓글삭제
	public int DeleteReply (String idx);
	
}
