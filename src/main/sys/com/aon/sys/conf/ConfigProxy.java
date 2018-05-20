package com.aon.sys.conf;

import java.beans.Introspector;
import java.io.IOException;
import java.io.InputStream;
import java.lang.annotation.Annotation;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.aon.sys.conf.ConfigUI.UI;

class ConfigProxy implements InvocationHandler
{
	private static Log _log = LogFactory.getLog(ConfigProxy.class);

	private Map<Method, String> _keys = new HashMap<Method, String>();

	public ConfigProxy(Class<?> clazz)
	{
		setKeys(clazz);
		setDefaults(clazz);
	}

	/**
	 * key를 추출한다.
	 */
	private void setKeys(Class<?> clazz)
	{
		Method[] methods = clazz.getMethods();
		for (int i = 0; i < methods.length; i++)
		{
			Annotation[]  annotations = methods[i].getAnnotations();
            String name = null;
			for(Annotation annotation: annotations){
				if(annotation instanceof ConfigKey){
					name = ((ConfigKey) annotation).value();
				}
			}
			
			String key = clazz.getName() + '.' + Introspector.decapitalize(name);
			_keys.put(methods[i], key);
		}
	}
	

	
	
	/**
	 * properties 파일에서 초기값을 읽는다.
	 */
	private static void setDefaults(Class<?> clazz)
	{
		String path = "/" + clazz.getName().replace('.', '/') + ".properties";
		Properties prop = new Properties();
		try
		{
			InputStream is = clazz.getResourceAsStream(path);
			if (is == null)
			{
				_log.warn("Cannot find properties file " + path);
			}
			else
			{
				prop.load(is);
			}
		}
		catch (IOException e)
		{
			_log.warn("Error loading properties file " + path, e);
		}

		for (Iterator<Object> i = prop.keySet().iterator(); i.hasNext();)
		{
			String key = (String) i.next();
			String value = prop.getProperty(key);
			ConfigCache.setDefaultProperty(clazz.getName() + '.' + key, value);
		}
	}

	/**
	 * 주어진 함수에 대응하는 객체를 돌려준다.
	 */
	public synchronized Object invoke(Object proxy, Method method, Object[] args)
	{
		String key = (String) _keys.get(method);
		String value = ConfigCache.getProperty(key);
		if (value == null)
		{
			return null;
		}

		Class<?> type = method.getReturnType();
		try
		{
			return ConvertUtils.convert(value, type);
		}
		catch (Exception e)
		{
			_log.warn("Cannot convert " + value + " to " + type.getName(), e);
			return null;
		}
	}

}
