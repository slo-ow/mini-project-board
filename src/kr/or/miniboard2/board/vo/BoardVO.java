package kr.or.miniboard2.board.vo;

import java.sql.Timestamp;
import java.util.List;

import kr.or.miniboard2.common.vo.PageVo;
import kr.or.miniboard2.file.vo.FileInfoVo;

public class BoardVO extends PageVo{
	
	private int gubun;
	private int idx;
	private int pidx; 
	private String title;
	private String content;
	private String writer;
	private String mail;
	private String ip;
	private Timestamp date;
	private int grp;
	private int seq;
	private int hit;
	private String delck;
	private List<FileInfoVo> filelist;
	private String lvl;
	
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getLvl() {
		return lvl;
	}
	public void setLvl(String lvl) {
		this.lvl = lvl;
	}
	public int getGrp() {
		return grp;
	}
	public void setGrp(int grp) {
		this.grp = grp;
	}	
	public int getGubun() {
		return gubun;
	}
	public void setGubun(int gubun) {
		this.gubun = gubun;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getPidx() {
		return pidx;
	}
	public void setPidx(int pidx) {
		this.pidx = pidx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getDelck() {
		return delck;
	}
	public void setDelck(String delck) {
		this.delck = delck;
	}
	public List<FileInfoVo> getFilelist() {
		return filelist;
	}
	public void setFilelist(List<FileInfoVo> filelist) {
		this.filelist = filelist;
	}
	
	
	
	
}
