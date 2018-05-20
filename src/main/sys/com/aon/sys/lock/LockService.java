package com.aon.sys.lock;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 
 * <pre>
 * try
 * {
 * 	LockService.lock();
 * 	...
 * }
 * finally
 * {
 * 	LockService.unlock();
 * }
 * </pre>
 */
public abstract class LockService
{
	private static ThreadLocal<LockSession> sessions = new ThreadLocal<LockSession>()
	{
		protected LockSession initialValue()
		{
			return new LockSession();
		}
	};
	private static Log logger = LogFactory.getLog(LockService.class);

	public static void lock(String s) throws Exception
	{
		if (logger.isDebugEnabled())
		{
			logger.debug("acquiring lock..." + s);
		}
		sessions.get().lock();
		if (logger.isDebugEnabled())
		{
			logger.debug("acquired lock.");
		}
	}

	public static void unlock() throws Exception
	{
		sessions.get().unlock();
		if (logger.isDebugEnabled())
		{
			logger.debug("released lock.");
		}
	}

}
