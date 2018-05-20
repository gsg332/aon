package com.aon.sys.conf;

import java.beans.Introspector;
import java.io.StringWriter;
import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;
import org.apache.velocity.app.event.EventCartridge;
import org.apache.velocity.runtime.RuntimeConstants;
import org.apache.velocity.tools.generic.DateTool;

import com.aon.sys.conf.ConfigUI.UI;



public class ConfigService
{
	private static Map<Class<?>, ConfigProxy> _handlers = new HashMap<Class<?>, ConfigProxy>();
	private static VelocityEngine engine = new VelocityEngine();
 
	public static void init() throws Exception
	{
		engine.setProperty("input.encoding", ConfigTemplate.ENCODING);
		engine.setProperty("resource.loader", "templateLoader");
		engine.setProperty("templateLoader.resource.loader.class", ConfigTemplate.class
			.getName());
		engine.setProperty("templateLoader.resource.loader.cache", "true");
		engine.setProperty(
			"templateLoader.resource.loader.modificationCheckInterval",
			"1");
		engine.setProperty(
			RuntimeConstants.RUNTIME_LOG_LOGSYSTEM_CLASS,
			"org.apache.velocity.runtime.log.SimpleLog4JLogSystem");
		engine
			.setProperty("runtime.log.logsystem.log4j.category", "org.apache.velocity");
		engine.setProperty("velocimacro.library", "");
		engine.setProperty("resource.manager.logwhenfound", "false");
		engine.init();
	}

	/**
	 * 환경 설정을 돌려준다.
	 * <p>
	 * dynamic proxy를 사용하지 않고 String 값을 돌려준다.
	 */
	public static String getProperty(String key)
	{
		return ConfigCache.getProperty(key);
	}

	/**
	 * 환경 설정을 돌려준다.
	 * <p>
	 * dynamic proxy를 사용하지 않고 String 값을 직접 boolean으로 변환하여 돌려준다.
	 */
	public static boolean getBooleanProperty(String key)
	{
		String value = ConfigCache.getProperty(key);
		return Boolean.valueOf(value).booleanValue();
	}
	
	
	/**
	 * 주어진 이름의 template과 주어진 map을 merge한다.
	 */
	public static String merge(String name, Map<String, Object> map) throws Exception
	{
		StringWriter writer = new StringWriter();

		VelocityContext context = new VelocityContext(map);
		context.put("date", new DateTool());
		EventCartridge ec = new EventCartridge();
		ec.attachToContext(context);
		
		Template template = engine.getTemplate(name);
		template.merge(context, writer);

		return writer.toString();
	}
	
	public static List<Properties> getKeyAndUI(Class<?> clazz){
		List<Properties> result = new LinkedList<Properties>();
		Method[] methods = clazz.getMethods();
		for (int i = 0; i < methods.length; i++)
		{
			Annotation[]  annotations = methods[i].getAnnotations();
            UI type = null;
            String name = null;

			for(Annotation annotation: annotations){
				if(annotation instanceof ConfigUI){
					type = ((ConfigUI) annotation).type();
				}
				if(annotation instanceof ConfigKey){
					name = ((ConfigKey) annotation).value();
				}
			}
			
			String key = clazz.getName() + '.' + Introspector.decapitalize(name);
			Properties prop = new Properties();
			prop.setProperty("key", key);
			prop.setProperty("value", ConfigCache.getProperty(key));
			prop.setProperty("UI", type.getTag());
			
			result.add(prop);
		}
		
		return result;
		
	}




	/**
	 * ConfigProxy 객체를 돌려준다.
	 * <p>
	 * default properties 파일을 읽는다.
	 */
	public static synchronized Object getConfig(Class<?> clazz)
	{
		ConfigProxy handler = (ConfigProxy) _handlers.get(clazz);
		if (handler == null)
		{
			handler = new ConfigProxy(clazz);
			_handlers.put(clazz, handler);
		}
		return Proxy.newProxyInstance(
			clazz.getClassLoader(),
			new Class[] { clazz },
			handler);
	}
}