package com.aon.sys.conf;

import java.util.Iterator;
import java.util.List;
import java.util.Properties;

import javax.persistence.Query;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.aon.lib.jpa.EntityManagerService;
import com.aon.sys.lock.LockService;


/**
 * 환경설정 정보를 관리한다.
 * <p>
 * start 후 부터 동기화 된다.테스트 해야함. <----변경사항을 cache에 적용해야 하기 때문에 내부적으로 lock과 transaction이 관리된다. (즉, manager를 호출하면 현재
 * transaction이 commit되거나 rollback된다).
 */
class ConfigManager
{
	
	/**
	 * 환경 설정 정보를 돌려준다.
	 */
	@SuppressWarnings("unchecked")
	static Properties getProperties(boolean init) throws Exception
	{
		try
		{
			if (init)
				LockService.lock("ConfigManager.init");
			Query query = EntityManagerService.createNamedQuery("com.aon.sys.conf.findAll");
			List<Config> l = query.getResultList();

			//EntityManagerService.commit();
			return convert(l);
		}
		catch (Exception e)
		{
			//EntityManagerService.rollback();
			throw e;
		}
		finally
		{
			if (init)
				LockService.unlock();
		}
	}

	/**
	 * 환경설정 변경사항을 db에 저장한다.
	 * <p>
	 * <code>List</code>에 포함되어 있지 않은 key에 대해서는 변경이 일어나지 않는다.
	 */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	void updateConfigList(List<Config> l) throws Exception
	{
		try
		{
			LockService.lock("ConfigManager.update"); // multiple row update
			//EntityManagerService.begin();
			
			new ConfigGateway().update(l);
			
			//EntityManagerService.commit();
			ConfigRemote.update(convert(l));
		}
		//catch (Exception e)
		//{
			//EntityManagerService.rollback();
		//	throw e;
		//}
		finally
		{
			LockService.unlock();
		}
	}
	
	/**
	 * Config의 List를 Properties로 변환한다.
	 */
	private static Properties convert(List<Config> l)
	{
		Properties p = new Properties();
		for (Config c : l)
		{
			String key = c.getKey();
			String value = c.getValue();
			if (key == null || value == null)
			{
				continue;
			}
			p.setProperty(key, value);
		}
		return compose(p);
	}

	/**
	 * value가 커서 array로 나뉜 속성을 합친다.
	 */
	private static Properties compose(Properties prop)
	{
		Properties p = new Properties();
		for (Iterator<Object> i = prop.keySet().iterator(); i.hasNext();)
		{
			String key = (String) i.next();
			String value = prop.getProperty(key).trim();
			if (key.endsWith("[]"))
			{
				key = key.substring(0, key.length() - 2);
				value = getValue(prop, key, value);
			}
			if (key.endsWith("]") || value.length() == 0)
			{
				continue;
			}
			p.setProperty(key, value);
		}
		return p;
	}

	/**
	 * 다중 값을 추출한다.
	 */
	private static String getValue(Properties prop, String key, String value)
	{
		int length = Integer.parseInt(value);

		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < length; i++)
		{
			sb.append(prop.get(key + '[' + i + ']'));
		}
		return sb.toString();
	}

}
