package com.aon.lib.repo;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

public abstract class RepositoryService
{
	private static int bufferSize = 8 * 1024;
	private static String attachmentCharset = "euc-kr";

	
	/**
	 * InputStream을 OuputStream으로 복사한다.
	 * <p>
	 * InputStream과 OuputStream을 닫지 않는다.
	 * @return 총 복사된 byte 크기를 돌려준다.
	 */
	public static long copy(InputStream src, OutputStream dst) throws IOException
	{
		return copy(src, dst, 0);
	}

	/**
	 * InputStream을 OuputStream으로 복사한다.
	 * <p>
	 * InputStream과 OuputStream을 닫지 않는다.
	 * <p>
	 * 주어진 offset 만큼 InputStream 을 skip 한다.
	 * @return 총 복사된 byte 크기를 돌려준다.
	 */
	public static long copy(InputStream src, OutputStream dst, long offset)
		throws IOException
	{
		long totalBytes = 0;
		byte b[] = new byte[bufferSize];
		src.skip(offset);
		while (true)
		{
			int readBytes = src.read(b, 0, bufferSize);
			if (readBytes < 0)
			{
				break;
			}
			totalBytes += readBytes;
			dst.write(b, 0, readBytes);
		}
		return totalBytes;
	}

	/**
	 * File을 OuputStream으로 복사한다. OuputStream을 닫지 않는다.
	 */
	public static long copy(File src, OutputStream dst) throws Exception
	{
		return copy(src, dst, 0);
	}

	public static long copy(File src, OutputStream dst, long offset) throws Exception
	{
		FileInputStream fis = null;
		try
		{
			fis = new FileInputStream(src);
			return copy(fis, dst, offset);
		}
		finally
		{
			if (fis != null)
			{
				fis.close();
			}
		}
	}

	/**
	 * InputStream을 File로 복사한다. InputStream을 닫지 않는다.
	 */
	public static long copy(InputStream src, File dst) throws Exception
	{
		FileOutputStream fos = null;
		try
		{
			fos = new FileOutputStream(dst);
			return copy(src, fos);
		}
		finally
		{
			if (fos != null)
			{
				fos.close();
			}
		}
	}

	public static long copy(File src, File dst) throws Exception
	{
		InputStream is = null;
		OutputStream os = null;
		try
		{
			is = new FileInputStream(src);
			os = new FileOutputStream(dst);
			return copy(is, os);
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

	private static Map<Integer, Repository> repositories = new HashMap<Integer, Repository>();
	private static Integer defaultRepository = new Integer(1000);
	private static Integer thumbRepository = null;

	/**
	 * repositroy를 등록한다.
	 */
	public static void addRepository(Integer type, Repository repository)
	{
		repositories.put(type, repository);
	}

	/**
	 * default로 파일이 저장될 repository의 type을 설정한다.
	 */
	public static void setDefaultRepositoryType(Integer repository)
	{
		defaultRepository = repository;
	}

	/**
	 * Repository를 return한다.
	 */
	public static Repository getRepository(Integer type)
		throws RepositoryNotFoundException
	{
		Repository m = (Repository) repositories.get(type);
		if (m == null)
		{
			throw new RepositoryNotFoundException();
		}
		return m;
	}

	/**
	 * Default Repository Type 값을 돌려준다.
	 */
	public static Integer getDefaultRepositoryType()
	{
		return defaultRepository;
	}

	/**
	 * 썸네일 Repository Type 값을 설정한다.
	 * @param thumbRepository
	 */
	public static void setThumbRepositoryType(Integer defaultRepository)
	{
		thumbRepository = defaultRepository;
	}

	/**
	 * 썸네일 Repository Type 값을 돌려준다.
	 * <p>
	 * null이고 Default Repository Type 이 FileRepository 일 경우 ThumbnailRepository 코드를 돌려준다.
	 * <p>
	 * 기타의 경우 Default Repository Type을 돌려준다.
	 * @return
	 */
	public static Integer getThumbRepository() throws Exception
	{
		return (null != thumbRepository)
			? thumbRepository
			: (getRepository(getDefaultRepositoryType()) instanceof FileRepository)
				? new Integer(1200)
				: getDefaultRepositoryType();
	}
	
	
	public static String encodeFilename(String filename)
			throws UnsupportedEncodingException
		{
			if (filename == null
				|| attachmentCharset == null
				|| "".equals(attachmentCharset))
			{
				return filename;
			}
			return new String(filename.getBytes(attachmentCharset), "8859_1");
		}
}
