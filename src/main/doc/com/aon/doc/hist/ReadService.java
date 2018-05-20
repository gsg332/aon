package com.aon.doc.hist;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.aon.doc.BaseDoc;
import com.aon.lib.jpa.ClassMetaData;
import com.aon.lib.jpa.EntityManagerService;

public class ReadService {
	
	private static Log logger = LogFactory.getLog(ReadService.class);
	private static final int TODO = 0;
	private static final int DONE = 1;

	/**
	 * Class와 맵핑된 테이블명 
	 */
	private String tableName;
	
	/**
	 * Class와 맵핑된 primary key field name
	 */
	private String identifierName;
	
	/**
	 * TODO: 중복 조회를 처리 
	 */
	private String readTable;
	

	public ReadService(Class<?> clazz) {
		tableName = ClassMetaData.getTableName(clazz);
		identifierName = ClassMetaData.getIdentifierCoulumnName(clazz);

	}

	/**
	 * 조회수를 증가시킨다.
	 */
	private void read(BaseDoc doc) throws Exception {

		String sql = "update "+tableName+" set "
				+"read_count = read_count +1 where "+identifierName+"=?";
		logger.debug("read sql:"+sql);
		EntityManagerService.createNativeQuery(sql).setParameter(1, doc.getId()).executeUpdate();
	
	}

	/**
	 * 조회 로그를 남긴다.
	 */
	private void readLog(Integer cmdCode, BaseDoc doc, int statFlag) throws Exception {
		//조회로그 남김. 
		
	}

	
	/**
	 * 조회수 처리를 하고 조회 로그를 남긴다.
	 */
	public void read(Integer cmdCode, BaseDoc doc) throws Exception {

		//TODO:본인제외 
		read(doc);
		readLog(cmdCode, doc, DONE);
		
		//공통처리 
		doc.setTransientCount(doc.getReadCount() + 1);
	}
}
