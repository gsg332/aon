package com.aon.lib.repo;

import java.io.File;

/**
 * 썸네일을 File System에 저장한다.
 * <p>
 * 일반 File Repository와 구분하기 위하여 sub 폴더를 지정해준다.
 * 기본적으로 쎔네일 파일은 root에 저장된다. 썸네일 파일도 일반 File과 동일하게 추가된 Disk에 분산해서 저장하고자 할 경우에는
 * totalDisks와 storeDisks를 지정해주면 된다.
 */
public class ThumbnailRepository extends FileRepository
{
	private boolean checkRoot = false;
	/**
	 * 파일이 저장될 서브 폴더명
	 */
	private String _sub = "thumb";

	/**
	 * 파일이 저장될 서브 폴더명을 돌려준다.
	 * @return
	 */
	public String getSub()
	{
		return _sub;
	}

	/**
	 * 파일이 저장될 서브 폴더명을 설정한다.
	 * @param sub
	 */
	public void setSub(String sub)
	{
		_sub = sub;
	}

	/**
	 * repository의 root를 설정한다.
	 */
	public void setRoot(String root)
	{
		checkRoot = true;
		super.setRoot(root);
	}

	/**
	 * repository의 root를 돌려준다.
	 */
	public String getRoot()
	{
		try
		{
			if (!checkRoot)
			{
				Repository repo = RepositoryService.getRepository(RepositoryService
					.getDefaultRepositoryType());
				if (repo instanceof FileRepository)
				{
					setRoot(((FileRepository) repo).getRoot());
				}
				checkRoot = true;
			}
		}
		catch (Exception e)
		{
		}
		return super.getRoot();
	}

	/**
	 * 파일이 저장될 위치를 돌려준다.
	 */
	protected StringBuffer getPath()
	{
		return super.getPath().insert(0, File.separatorChar).insert(0, getSub());
	}
}
