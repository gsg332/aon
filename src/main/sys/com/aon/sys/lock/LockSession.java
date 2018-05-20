package com.aon.sys.lock;

import java.io.Serializable;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.aon.lib.jpa.EntityManagerService;



class LockSession implements Serializable
{
	private static final long serialVersionUID = 7241217263632243288L;

	private Session _session;
	private Transaction _transaction;

	///M
	private static String lock = "Lock Tables SA_LOCK WRITE";
	
	private static String unlock ="Unlock TABLES";
	
	void lock() throws Exception
	{
		SessionFactory sf = ((Session)EntityManagerService.getEntityManager().getDelegate()).getSessionFactory();
		// 이미 lock이 걸린 경우 새로 lock을 걸지 않는다.
		if (_session == null)
		{
			_session = sf.openSession();
			_transaction = _session.beginTransaction();
			_session.createSQLQuery(lock).executeUpdate();

		}
	}

	 
	void unlock() throws Exception
	{
		Session s = _session;
		try
		{
			_session.createSQLQuery(unlock).executeUpdate();

			_transaction.commit();
	
		} catch (Exception e) {
			_transaction.rollback();
			throw e;
		}
		finally
		{
			_session = null;
			_transaction = null;
			s.close();
		}
	}

}
