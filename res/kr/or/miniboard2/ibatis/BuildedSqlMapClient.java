package kr.or.miniboard2.ibatis;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.Reader;
import java.nio.charset.Charset;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class BuildedSqlMapClient {
	private static SqlMapClient client = null; // 게터세터와 같이 캡슐화하기위해 private
	
	static {
		try {
			Charset ch = Charset.forName("UTF-8");
			Resources.setCharset(ch); // xml가져옴
			Reader reader = Resources.getResourceAsReader("/kr/or/miniboard2/ibatis/SqlMapConfig.xml");
			client = SqlMapClientBuilder.buildSqlMapClient(reader);
		} catch(FileNotFoundException e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		} catch(IOException e) {
			e.printStackTrace();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			
		}
	}
	
	
	public static SqlMapClient getSqlMapClient() {
		return client;
	}
	
	
	
	
	
	
	
	
	
	
}
