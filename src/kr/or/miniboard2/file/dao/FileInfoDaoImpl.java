package kr.or.miniboard2.file.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.miniboard2.file.vo.FileInfoVo;
import kr.or.miniboard2.ibatis.BuildedSqlMapClient;


public class FileInfoDaoImpl implements FileInfoDao{
	
	private static FileInfoDao dao = null;
	private SqlMapClient client = null;
	
	private FileInfoDaoImpl(){
		client = BuildedSqlMapClient.getSqlMapClient();
	}
	
	public static FileInfoDao getDao(){
		if(dao==null){
			dao = new FileInfoDaoImpl();
		}
		return dao;
	}

	// 멀티파일업로드
	@Override
	public int insertFileinfo(FileInfoVo vo) throws SQLException {
		System.out.println("멀티파일 업로드 vo 값 확인 : " + vo);		
		return (int) client.insert("fileinfo.insertFileInfo",vo);
	}
	
	//조회
	public List<FileInfoVo> selectFileInfo(int bno) throws SQLException{
		return client.queryForList("fileinfo.selectFileInfo",bno);
		
	}
	
	//파일 원본이름찾기(다운로드)
	@Override
	public String selectFileName(String file) throws SQLException {
		System.out.println("[쿼리동작] : "+file + " 찾으려는 파일이름");
		return (String) client.queryForObject("fileinfo.selectFileName",file);
	}

}
