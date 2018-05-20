package com.aon.sys.conf;

import java.util.Date;
import java.util.Properties;

import com.aon.lib.cache.CacheCommand;
import com.aon.lib.cache.CacheService;



/**
 * Config를 캐시에 반영하는 Class
 */
public abstract class ConfigRemote
{

	/**
	 * 전달된 Config properties를 캐시에 반영한다.
	 */
	@SuppressWarnings("serial")
	public static void update(final Properties prop) throws Exception
	{
		CacheService.send(new CacheCommand()
		{
			public void execute()
			{
				Properties cache = (Properties) CacheService.get(ConfigCache.class);
				cache.putAll(prop);
				ConfigCache.setLastModified(new Date());
			}
		});

	}
}
