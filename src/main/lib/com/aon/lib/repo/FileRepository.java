package com.aon.lib.repo;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


public class FileRepository implements Repository
{
	private static Log _log = LogFactory.getLog(FileRepository.class);

	private String _root = "/repository";
	private Map<String, String> _totalDisks = new HashMap<String, String>();
	private List<String> _storeDisks = new LinkedList<String>();

	private int _depth = 3;
	private int _width = 10;
	private String _prefix = "aon";

	/**
	 * repository의 root를 설정한다.
	 */
	public void setRoot(String root)
	{
		_root = root;
	}

	/**
	 * repository의 root를 돌려준다.
	 */
	public String getRoot()
	{
		return _root;
	}

	/**
	 * 전체 Disk들을 설정한다.
	 */
	public void setTotalDisks(Map<String, String> totalDisks)
	{
		_totalDisks = totalDisks;
	}

	/**
	 * 확장 Disk들을 Map으로 돌려준다.
	 */
	public Map<String, String> getTotalDisks()
	{
		return _totalDisks;
	}

	/**
	 * Store 가능한 Disk들을 설정한다.
	 */
	public void setStoreDisks(List<String> storeDisks)
	{
		_storeDisks = storeDisks;
	}

	/**
	 * Store 가능한 Disk들을 List로 돌려준다.
	 */
	public List<String> getStoreDisks()
	{
		return _storeDisks;
	}

	/**
	 * 파일명의 Prefix 값을 설정한다.
	 */
	public void setPrefix(String prefix)
	{
		_prefix = prefix;
	}

	/**
	 * hashing할 디렉토리의 깊이를 설정한다.
	 * <p>
	 * 양수가 아닌 경우 default 값인 3으로 설정된다.
	 */
	public void setDepth(int depth)
	{
		_depth = (depth > 0) ? depth : 3;
	}

	/**
	 * hashing할 디렉토리의 너비를 설정한다.
	 * <p>
	 * 양수가 아닌 경우 default 값이 10으로 설정된다.
	 */
	public void setWidth(int width)
	{
		_width = (width > 0) ? width : 10;
	}

	/**
	 * 해당 path의 파일을 OutputStream으로 출력한다.
	 */
	public long write(String path, OutputStream os) throws Exception
	{
		return write(path, os, 0);
	}

	/**
	 * 해당 path의 파일을 주어진 offset 부터 OutputStream으로 출력한다.
	 */
	public long write(String path, OutputStream os, long offset) throws Exception
	{
		if (_log.isDebugEnabled())
		{
			_log.debug("Loading " + path);
		}
		File src = getFile(path);
		return RepositoryService.copy(src, os, offset);
	}

	public long write(String path, String dst) throws Exception
	{
		File src = getFile(path);
		return RepositoryService.copy(src, new File(dst));
	}

	/**
	 * 해당 path의 파일을 삭제한다.
	 */
	public void delete(String path) throws Exception
	{
		File src = getFile(path);
		boolean result = src.delete();
		if (result == false)
		{
			_log.warn("Cannot delete " + path);
		}
		else if (_log.isDebugEnabled())
		{
			_log.debug("Deleted " + path);
		}
	}

	/**
	 * 다른 Repository에 저장되어 있는 파일을 복사하고, 복사된 경로를 돌려준다.
	 * <p>
	 * file의 path와 filesize가 설정된다.
	 */
	public String store(RepositoryFile file) throws Exception
	{
		String path = generatePath(file.getFilename());
		OutputStream os = null;
		try
		{
			File dst = getFile(path);
			os = new FileOutputStream(dst);
			file.write(os);
		}
		finally
		{
			if (os != null)
			{
				os.close();
			}
		}
		if (_log.isDebugEnabled())
		{
			_log.debug("Stored " + path);
		}
		return path;
	}

	/**
	 * path로 지정된 파일이 저장된 경로를 나타내는 실제 File 객체를 돌려준다.
	 * <p>
	 * Disk Key를 포함할 수 있다. 이 경우에는 totalDisks에서 disk의 root를 찾는다.
	 */
	protected File getFile(String path) throws Exception
	{
		if (getRoot() == null)
		{
			throw new FileRepositoryException();
		}
		else
		{
			return new File(getRootPath(path), escapeDiskKey(path));
		}
	}

	/**
	 * 파일이 저장된 Disk의 Root를 구하여 돌려준다.
	 * @param path
	 * @return
	 */
	protected String getRootPath(String path)
	{
		if (path.startsWith("["))
		{
			int idx = path.indexOf("]");
			return getTotalDisks().get(path.substring(1, idx));
		}
		return getRoot();
	}

	/**
	 * path에서 Disk Key를 제거한다.
	 * @param path
	 * @return
	 */
	protected String escapeDiskKey(String path)
	{
		if (path.startsWith("["))
		{
			int idx = path.indexOf("]");
			return path.substring(idx + 1);
		}
		return path;
	}

	/**
	 * 신규 파일을 생성할 경로를 계산 후 실제 File 객체를 돌려준다.
	 */
	protected File createFile(String diskPath, String path) throws Exception
	{
		if (diskPath == null)
		{
			throw new FileRepositoryException();
		}
		else
		{
			return new File(diskPath, path);
		}
	}

	/**
	 * 새로운 파일을 저장할 path를 생성한다.
	 */
	protected String generatePath(String filename) throws Exception
	{
		StringBuffer path = getPath();

		File dir = null;

		if (getStoreDisks() != null && getStoreDisks().size() > 0)
		{
			int diskIdx = (int) (Math.random() * getStoreDisks().size());
			String diskKey = getStoreDisks().get(diskIdx);
			String diskPath = getTotalDisks().get(diskKey);

			dir = createFile(diskPath, path.toString());

			path.insert(0, "[" + diskKey + "]");
		}
		else
		{
			dir = getFile(path.toString());
		}

		if (!dir.exists())
		{
			_log.info("Creating repository " + dir.getAbsolutePath());
			dir.mkdirs();
		}
		// unique한 filename을 받아오기 위해 임시파일을 생성한 후, 복사나 이동을 위해 다시 삭제한다.
		// cluster 환경이 아닌 경우에는 JVM을 restart하기 전에는 같은 이름의 파일이 생성되지 않으므로 삭제해도
		// 안전하다.
		File dst = File.createTempFile((_prefix != null) ? _prefix : "aon", "", dir);
		dst.delete();

		int i = filename.lastIndexOf('.');
		String ext = (i < 0) ? "" : filename.substring(i);
		path.append(dst.getName()).append(ext);
		return path.toString();
	}

	/**
	 * 파일이 저장될 위치를 돌려준다.
	 * @return
	 */
	protected StringBuffer getPath()
	{
		StringBuffer path = new StringBuffer();
		for (int i = 0; i < _depth; i++)
		{
			path.append((int) (Math.random() * _width));
			path.append(File.separatorChar);
		}
		return path;
	}

	/**
	 * 파일의 날짜를 돌려준다.
	 * <p>
	 * 썸네일 삭제 등에 활용한다. crontab, job등에서 사용한다.
	 * @param path
	 * @return
	 * @throws Exception
	 */
	public Date getFiledate(String path) throws Exception
	{
		File file = getFile(path);
		long longdate = file.lastModified();
		return new Date(longdate);
	}

}