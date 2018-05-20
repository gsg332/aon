package com.aon.lib.repo;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;

/**
 * URL경로 상의 파일을 저장한다.
 */
public class UrlRepository implements Repository
{
	
    public long write(String path, OutputStream os) throws Exception
    {
        return write(path, os, 0);
    }
    
    /**
	 * url 경로의 파일을 OutputStream으로 복사한다.
	 */
	public long write(String path, OutputStream os, long offset) throws Exception
	{
		InputStream is = null;
		try
		{
			URL url = new URL(path);
			URLConnection uc = url.openConnection();
			uc.connect();
			is = uc.getInputStream();
			return RepositoryService.copy(is, os, offset);
		}
		finally
		{
			if (is != null)
			{
				is.close();
			}
		}
	}

	/**
	 * 저장할 수 없다. UnsupportedOperationException을 던진다.
	 */
	public String store(RepositoryFile file) throws Exception
	{
		throw new UnsupportedOperationException();
	}

	/**
	 * 삭제할 수 없다. UnsupportedOperationException을 던진다.
	 */
	public void delete(String path) throws Exception
	{
		throw new UnsupportedOperationException();
	}

	public long write(String path, String dst) throws Exception
	{
		InputStream is = null;
		OutputStream os = null;
		try
		{
			URL url = new URL(path);
			URLConnection uc = url.openConnection();
			uc.connect();
			is = uc.getInputStream();
			os = new FileOutputStream(dst);
			return RepositoryService.copy(is, os);
		}
		finally
		{
			if (is != null)
			{
				is.close();
			}
			if (os != null)
			{
				os.close();
			}
		}
	}

}
