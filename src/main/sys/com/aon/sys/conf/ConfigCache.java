package com.aon.sys.conf;

import java.util.Date;
import java.util.Properties;

import com.aon.lib.cache.CacheService;


/**
 * Config 정보 캐시를 관리하는 Class
 */
abstract class ConfigCache {
	private static Properties _defaults = new Properties();
	private static long _lastModified = 0;

	/**
	 * cache를 초기화한다.
	 */
	static void init() throws Exception {

		//Properties prop = ConfigManager.getProperties(false);
		//CacheService.put(ConfigCache.class, prop);
		//ConfigCache.setLastModified(new Date());
		/**
		 * 전체를 config를 등록시킨다. 초기화 할때는 cluster 되지 않는다.
		 */
		if (getProperties() == null) {
			try {
				Properties prop = ConfigManager.getProperties(true);
				CacheService.put(ConfigCache.class, prop);
			} catch (Exception e) {
				// CacheService.put(ConfigCache.class, new Properties());//test용
				e.printStackTrace();
			}
		}

	}

	/**
	 * Cache된 Config 전체목록을 돌려준다.
	 */
	private static Properties getProperties() {
		return (Properties) CacheService.get(ConfigCache.class);
	}

	/**
	 * 전달된 key를 default Config에 set 한다.
	 */
	static void setDefaultProperty(String key, String value) {
		_defaults.setProperty(key, value.trim());
	}

	/**
	 * 환경 설정을 돌려준다. default 설정값을 포함한다.
	 */
	static Properties getAllProperties() {
		Properties prop = new Properties();
		prop.putAll(_defaults);
		if(!getProperties().isEmpty())
			prop.putAll(getProperties());
		return prop;
	}

	/**
	 * 환경 설정을 돌려준다.
	 */
	static String getProperty(String key) {
		String value = getProperties().getProperty(key);
		if (value == null || value.length() == 0) {
			return _defaults.getProperty(key);
		}
		return value;
	}

	/**
	 * 환경 설정이 마지막으로 변경된 시점을 설정한다.
	 */
	static synchronized void setLastModified(Date d) {
		_lastModified = d.getTime();
	}

	/**
	 * 환경 설정이 마지막으로 변경된 시점을 돌려준다.
	 */
	static synchronized long getLastModified() {
		return _lastModified;
	}

}
