package kr.or.miniboard2.member.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.miniboard2.member.vo.MemberVo;

public interface MemberDao {
	
	//저장메소드
	public String insertMember(MemberVo vo) throws SQLException;
	
	//조회
	public List<MemberVo> selectAll() throws SQLException;
	
	public MemberVo  selectMember(String id,String pass) throws SQLException;
	
	//수정 
	public int updateMember(Map<String, String> paramMap) throws SQLException;

	//삭제 
	public int deleteMember(String id) throws SQLException;
	
}





