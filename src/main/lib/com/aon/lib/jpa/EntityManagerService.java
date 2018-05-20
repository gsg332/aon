package com.aon.lib.jpa;

import java.io.Serializable;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.querydsl.jpa.impl.JPAQuery;


public abstract class EntityManagerService {

	private static final Logger logger = LoggerFactory.getLogger(EntityManagerService.class);

	private static EntityManager entityManager;

	public static void init(EntityManager em) {
		entityManager = em;
		logger.debug(EntityManagerService.class+ " initialized....");
	}
	
	public static EntityManager getEntityManager() {
		return entityManager;
	}
	
	public static JPAQuery<?> getQuery() throws Exception {
		return  new JPAQuery<Void>(getEntityManager());
	}
	
	public static <T> TypedQuery<T> createQuery(String qlString, Class<T> resultClass) throws Exception{
		return getEntityManager().createQuery(qlString, resultClass);
	}
	
	public static javax.persistence.Query createNativeQuery(String sqlString) throws Exception{
		return getEntityManager().createNativeQuery(sqlString);
	}
	
	public static javax.persistence.Query createNativeQuery(String sqlString, @SuppressWarnings("rawtypes") Class resultClass) throws Exception{
		return getEntityManager().createNativeQuery(sqlString, resultClass);
	}
	
	public static javax.persistence.Query createNamedQuery(String name){
		return getEntityManager().createNamedQuery(name);
	}
	
	public static <T> T load(Class<T> clazz,Serializable ID){
		return getEntityManager().find(clazz, ID);
	}
	
	public static void remove(Object entity){
		getEntityManager().remove(entity);
	}
	
	public static void flush() {
		getEntityManager().flush();
	}
	
	public static void rollback(){
		getEntityManager().getTransaction().rollback();
	}
	
	public static void setRollbackOnly(){
		getEntityManager().getTransaction().setRollbackOnly();
	}
	
	public static void begin(){
		getEntityManager().getTransaction().begin();
	}
	
	public static void commit(){
		getEntityManager().getTransaction().commit();
	}
	
}
