package kr.or.miniboard2.board.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.miniboard2.board.vo.BoardVO;

public interface BoardDao {
	
	//게시판조회 + 검색
	public List<BoardVO> listAll(Map<String, Object> map) throws SQLException;
	
	//전체 글 개수 구하기
	public int listCount(Map<String, Object> map) throws SQLException;
	
	//게시글 작성
	public int insertBoard(BoardVO vo) throws SQLException;

	//게시글 상세보기
	public BoardVO detailBoard(int idx) throws SQLException;
	
	//게시글 조회수증가
	public void updateView(int idx) throws SQLException;
	
	//게시글 삭제
	public int deleteBoard(int no) throws SQLException;
	
	//게시글 수정
	public int updateBoard(BoardVO vo) throws SQLException;
	
	//댓글 작성
	public int insertReply(BoardVO vo)throws SQLException;
	
	//댓글 글순서(SEQ)증가
	public int updateSEQ(Map<String,Object> map) throws SQLException;
			
	//댓글 리스트
	public List<BoardVO> getReplylist(int idx) throws SQLException;
		
	//댓글삭제
	public int DeleteReply (String idx) throws SQLException;
	
}
