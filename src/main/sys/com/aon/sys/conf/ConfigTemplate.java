package com.aon.sys.conf;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;

import org.apache.commons.collections.ExtendedProperties;
import org.apache.velocity.exception.ResourceNotFoundException;
import org.apache.velocity.runtime.resource.Resource;
import org.apache.velocity.runtime.resource.loader.ResourceLoader;

/**
 * 환경설정 값으로 template을 생성할 수 있도록 velocity의 Resource Loader를 extend한다.
 */
public class ConfigTemplate extends ResourceLoader
{
	/**
	 * loader와 engine에서 사용할 encoding을 일치시켜야 한다.
	 */
	static final String ENCODING = "utf-8";

	/**
	 * 구현하지 않는다.
	 */
	public void init(ExtendedProperties arg0)
	{
	}

	/**
	 * 전달된 key값을 캐시에서 찾아 InputStream으로 반환한다.
	 */
	public InputStream getResourceStream(String arg0) throws ResourceNotFoundException
	{
		String template = ConfigService.getProperty(arg0);
		if (template == null)
		{
			throw new ResourceNotFoundException("Cannot find resource " + arg0);
		}
		try
		{
			return new ByteArrayInputStream(template.getBytes(ENCODING));
		}
		catch (UnsupportedEncodingException e)
		{
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * resource가 변경되었는지 여부를 돌려준다.
	 */
	public boolean isSourceModified(Resource arg0)
	{
		return (getLastModified(arg0) != arg0.getLastModified());
	}

	/**
	 * 마지막 캐시 변경일을 돌려준다.
	 */
	public long getLastModified(Resource arg0)
	{
		return ConfigCache.getLastModified();
	}

}
