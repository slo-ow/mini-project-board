package kr.or.miniboard2.file.vo;

import java.sql.Timestamp;

public class FileInfoVo {
	private int seq;
	private int bno;
	private String filename;
	private String originalname;
	private long filesize;
	private String extenstion; 
	private Timestamp filedate;
	
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getOriginalname() {
		return originalname;
	}
	public void setOriginalname(String originalname) {
		this.originalname = originalname;
	}
	public long getFilesize() {
		return filesize;
	}
	public void setFilesize(long filesize) {
		this.filesize = filesize;
	}
	public String getExtenstion() {
		return extenstion;
	}
	public void setExtenstion(String extenstion) {
		this.extenstion = extenstion;
	}
	public Timestamp getFiledate() {
		return filedate;
	}
	public void setFiledate(Timestamp filedate) {
		this.filedate = filedate;
	}
	
	
	
}
