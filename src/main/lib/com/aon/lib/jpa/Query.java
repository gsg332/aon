package com.aon.lib.jpa;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;

public abstract class Query {
	
	@PersistenceContext
	private EntityManager em;
	
	
	private EntityManager getEntityManager() throws Exception {
		if(em == null)
			 throw new NullPointerException("EntityManager is null");
		return em;
	}
     
	protected JPAQuery<?> getQuery() throws Exception {
		return  new JPAQuery<Void>(getEntityManager());
	}
	
	protected <T> TypedQuery<T> createQuery(String qlString, Class<T> resultClass) throws Exception{
		return getEntityManager().createQuery(qlString, resultClass);
	}
	
	protected javax.persistence.Query createNativeQuery(String sqlString) throws Exception{
		return getEntityManager().createNativeQuery(sqlString);
	}
	
	protected javax.persistence.Query createNativeQuery(String sqlString, @SuppressWarnings("rawtypes") Class resultClass) throws Exception{
		return getEntityManager().createNativeQuery(sqlString, resultClass);
	}
	
	protected javax.persistence.Query createNamedQuery(String name) throws Exception{
		return getEntityManager().createNamedQuery(name);
	}
	
	protected JPAQueryFactory getQueryFactory() throws Exception {
		return  new JPAQueryFactory(getEntityManager());
	}
	
	public <T> T find(Class<T> entityClass, Long id) throws Exception{
		return getEntityManager().find(entityClass, id);
	}
}
