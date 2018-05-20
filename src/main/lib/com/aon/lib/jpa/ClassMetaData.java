package com.aon.lib.jpa;

import java.util.HashMap;
import java.util.Map;

import javax.persistence.EntityManager;

import org.hibernate.Session;
import org.hibernate.metadata.ClassMetadata;
import org.hibernate.persister.entity.SingleTableEntityPersister;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public abstract class ClassMetaData {
	
	private static final Logger logger = LoggerFactory.getLogger(ClassMetaData.class);

	
	private static Map<String, String> TABLES = new HashMap<String, String>();
	/**
	 * 맵핑은 단일키로만한다.
	 */
	private static Map<String, String> IDENTIFIER = new HashMap<String, String>();
	
	
	public static void init(EntityManager em) throws ClassNotFoundException{
		Map<String,ClassMetadata> meta = ((Session)em.getDelegate()).getSessionFactory().getAllClassMetadata();
		logger.debug("ClassMetaData init.......");
		logger.debug("Meta init......."+ meta.size());

		for(String clazz : meta.keySet()){
			SingleTableEntityPersister step = (SingleTableEntityPersister) meta.get(clazz);
			TABLES.put(clazz,step.getTableName());
			logger.debug("class ......"+ clazz  + "  table name="+step.getTableName());

			IDENTIFIER.put(clazz, step.getIdentifierColumnNames()[0]);
		}
	}
	
	public static String getTableName(Class<?> clazz){
		logger.debug("clazz ......"+ clazz.getName()  + "  table name="+TABLES.get(clazz.getName()));
		return TABLES.get(clazz.getName());
	}
	
	public static String getIdentifierCoulumnName(Class<?> clazz){
		return IDENTIFIER.get(clazz.getName());
	}
}
