package com.aon.lib.repo;

import java.io.File;
import java.io.OutputStream;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 서버에서 생성하는 Temporary 파일에 대한 저장소이다.
 * <p>
 * 생성된 Temp File의 write 작업을 수행한다.
 */
public class TemporaryFileRepository implements Repository
{
	private static Log _log = LogFactory.getLog(TemporaryFileRepository.class);

	/**
	 * 해당 path 의 파일을 OutputStream 으로 출력한다.
	 */
	public long write(String path, OutputStream os) throws Exception
	{
		return write(path, os, 0);
	}

	/**
	 * 해당 Path 의 파일을 주어진 offset 부터 끝까지 OutputStream 으로 출력한다.
	 */
	public long write(String path, OutputStream os, long offset) throws Exception
	{
		if (_log.isDebugEnabled())
		{
			_log.debug("Loading " + path);
		}
		File src = new File(path);
		return RepositoryService.copy(src, os, offset);
	}

	public long write(String path, String dst) throws Exception
	{
		if (_log.isDebugEnabled())
		{
			_log.debug("Loading " + path);
		}
		File src = new File(path);
		return RepositoryService.copy(src, new File(dst));
	}

	/**
	 * 저장 기능은 별도 제공하지 않는다.
	 * <p>
	 * 임시파일을 생성 후 write용도로 사용되기 때문에...
	 */
	public String store(RepositoryFile file) throws Exception
	{
		throw new UnsupportedOperationException();
	}

	/**
	 * 생성 이후 자동으로 삭제되므로 아무일도 하지 않는다.
	 */
	public void delete(String path) throws Exception
	{
	}

}
