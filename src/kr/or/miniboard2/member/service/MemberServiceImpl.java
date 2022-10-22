package kr.or.miniboard2.member.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.miniboard2.member.dao.MemberDao;
import kr.or.miniboard2.member.dao.MemberDaoImpl;
import kr.or.miniboard2.member.vo.MemberVo;

//자기의 객체를 생성하고 리턴하고 dao객체를 가져온다 
public class MemberServiceImpl  implements MemberService{

	//dao객체선언
	private MemberDao  dao;
	
	//serviceImpl객체 생성
	private static MemberService  service = null; 
	
	//생성자-dao객체를 가져오기 
	private MemberServiceImpl(){
		dao = MemberDaoImpl.getDao();
	}
	
	//serviceImpl객체를 리턴하는 getService메소드
	public static MemberService getService(){
		if(service==null){
			service = new MemberServiceImpl();
		}
		return service;
	}
	
	@Override
	public String insertMember(MemberVo vo) {
		// dao의 메소드 호출 해서 결과값을 리턴받는다 
		String value= null;
	
		try {
			value=  dao.insertMember(vo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return value;
	}

	@Override
	public List<MemberVo> selectAll() {
		List<MemberVo>  list = null;
		
		try {
			list = dao.selectAll();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list ;
	}

	@Override
	public MemberVo selectMember(String id,String pass) {
		MemberVo vo = null;
		
		try {
			vo = dao.selectMember(id,pass);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return vo;
	}

	@Override
	public int updateMember(Map<String, String> paramMap) {
		int res =0;
		
		try {
			res = dao.updateMember(paramMap);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int deleteMember(String id) {
		int res =0;
		
		try {
			res = dao.deleteMember(id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}

}
