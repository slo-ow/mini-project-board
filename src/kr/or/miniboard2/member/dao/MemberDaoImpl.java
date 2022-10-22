package kr.or.miniboard2.member.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.miniboard2.ibatis.BuildedSqlMapClient;
import kr.or.miniboard2.member.vo.MemberVo;

//자기객체를 생성하고 sqlMapclient객체 를 얻어온다 
public class MemberDaoImpl implements MemberDao {

	//sqlMapClient객체 선언
	private SqlMapClient  sqlMap;
	//daoImpl객체 만들기(생성) 
	private static MemberDao  dao = null;
	
	//생성자 - sqlMapClient객체 만들기(가져오기)
	private MemberDaoImpl(){
		sqlMap = BuildedSqlMapClient.getSqlMapClient();
	}
	//daoImpl객체를 리턴하는 getDao()메소드 만들기 
	public static MemberDao getDao(){
		if(dao==null){
			dao = new MemberDaoImpl();
		}
		return dao;
	}
	
	@Override
	public String insertMember(MemberVo vo) throws SQLException {
		 
		return (String)sqlMap.insert("member.insertMember", vo);
	}

	@Override
	public List<MemberVo> selectAll() throws SQLException {
		List<MemberVo> list = sqlMap.queryForList("member.selectAll");
		return list;
	}

	@Override
	public MemberVo selectMember(String id, String pass) throws SQLException {
		Map<String,String> hashMap = new HashMap();
		hashMap.put("mem_id",id);
		hashMap.put("mem_pass",pass);
		
		MemberVo  vo = (MemberVo)sqlMap.queryForObject("member.selectMember", hashMap);
		return vo;
	}

	@Override
	public int updateMember(Map<String, String> paramMap) throws SQLException {
		int res = sqlMap.update("member.update", paramMap);
		return res;
	}

	@Override
	public int deleteMember(String id) throws SQLException {
		int res = sqlMap.delete("member.delete", id);
		return res;
	}

}



