package kr.or.miniboard2.board.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.miniboard2.ibatis.BuildedSqlMapClient;
import kr.or.miniboard2.board.vo.BoardVO;

public class BoardDaoImpl implements BoardDao {
	
	private static BoardDao dao = null;
	private SqlMapClient client = null;
	
	private BoardDaoImpl(){
		client = BuildedSqlMapClient.getSqlMapClient();
	}
	
	public static BoardDao getInstance(){
		if(dao == null){
			dao = new BoardDaoImpl();
		}
		return dao;
	}

	
	// 게시판 조회 + 검색기능
	@Override
	public List<BoardVO> listAll(Map<String, Object> map) throws SQLException {

		return client.queryForList("board.listAll", map);
	}

	// 전체 글 개수 구하기
	@Override
	public int listCount(Map<String, Object> map) throws SQLException {
		return (int) client.queryForObject("board.listCount", map);
	}
	
	// 글작성
	@Override
	public int insertBoard(BoardVO vo) throws SQLException {		
		return (int) client.insert("board.insertBoard",vo);
	}

	// 게시글 상세보기
	@Override
	public BoardVO detailBoard(int idx) throws SQLException {
		return (BoardVO) client.queryForObject("board.detailBoard",idx);
	}

	// 게시글 조회수증가
	@Override
	public void updateView(int idx) throws SQLException {
		client.update("board.updateView",idx);
	}

	// 게시글삭제 + 업로드파일까지 같이삭제
	@Override
	public int deleteBoard(int no) throws SQLException {		
		return (int)client.delete("board.deleteBoard",no);
	}
	
	// 게시글 수정
	@Override
	public int updateBoard(BoardVO vo) throws SQLException {		
		return (int)client.update("board.updateBoard",vo);
	}
	
	//댓글 작성
	@Override
	public int insertReply(BoardVO vo) throws SQLException {
		return (int)client.insert("board.insertReply",vo);
	}
	
	//댓글 글순서(SEQ)증가
	@Override
	public int updateSEQ(Map<String, Object> map) throws SQLException {
		return (int)client.update("board.updateSEQ",map);
	}
	
	//댓글 리스트
	@Override
	public List<BoardVO> getReplylist(int idx) throws SQLException {
		System.out.println("넘겨받은 댓글리스트idx값" + idx);
		return (List<BoardVO>)client.queryForList("board.getReplylist",idx);
	}

	//댓글삭제
	@Override
	public int DeleteReply(String idx) throws SQLException {		
		return (int)client.update("board.DeleteReply",idx);
	}



	
	
	
}
