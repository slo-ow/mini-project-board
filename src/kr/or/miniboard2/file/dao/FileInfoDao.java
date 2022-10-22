package kr.or.miniboard2.file.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.miniboard2.file.vo.FileInfoVo;


public interface FileInfoDao {
	
	//조회
	public List<FileInfoVo> selectFileInfo(int bno) throws SQLException;
	
	//저장(멀티파일업로드)
	public int insertFileinfo(FileInfoVo vo) throws SQLException;
	
	//파일 원본이름찾기(다운로드)
	public String selectFileName(String file) throws SQLException;
	
}
