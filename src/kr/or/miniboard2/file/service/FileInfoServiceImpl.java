package kr.or.miniboard2.file.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.miniboard2.file.dao.FileInfoDao;
import kr.or.miniboard2.file.dao.FileInfoDaoImpl;
import kr.or.miniboard2.file.vo.FileInfoVo;

public class FileInfoServiceImpl implements FileInfoService{	
	private static FileInfoServiceImpl service = null;
	private FileInfoDao dao;
	
	private FileInfoServiceImpl(){
		dao = FileInfoDaoImpl.getDao();
	}
	
	public static FileInfoService getInstance(){
		if(service == null){
			service = new FileInfoServiceImpl();
		}
		return service;
	}
	
	// 조회
	@Override
	public List<FileInfoVo> selectFileInfo(int bno) {
		List<FileInfoVo> list = null;
		try {
			list = dao.selectFileInfo(bno);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	// 저장(멀티파일업로드)
	@Override
	public int insertFileinfo(FileInfoVo vo) {
		int res = 0;
		try {
			res = dao.insertFileinfo(vo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}

	// 저장(멀티파일업로드)
	@Override
	public String selectFileName(String file) {
		String val = null;
		try {
			val = dao.selectFileName(file);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return val;
	}

}
