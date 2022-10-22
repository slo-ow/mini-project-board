package kr.or.miniboard2.member.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.miniboard2.member.vo.MemberVo;

public interface MemberService {

	// 저장메소드
	public String insertMember(MemberVo vo) ;

	// 조회
	public List<MemberVo> selectAll() ;
	
	// 회원조회
	public MemberVo selectMember(String id,String pass) ;

	// 수정
	public int updateMember(Map<String, String> paramMap) ;

	// 삭제
	public int deleteMember(String id) ;

}
