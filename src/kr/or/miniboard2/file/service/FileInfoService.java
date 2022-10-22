package kr.or.miniboard2.file.service;

import java.util.List;

import kr.or.miniboard2.file.vo.FileInfoVo;

public interface FileInfoService {

	//조회
	public List<FileInfoVo> selectFileInfo(int bno);
	
	//저장(멀티파일업로드)
	public int insertFileinfo(FileInfoVo vo);
	
	//파일 원본이름찾기(다운로드)
	public String selectFileName(String file);
}
