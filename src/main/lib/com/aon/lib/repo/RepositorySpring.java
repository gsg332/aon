package com.aon.lib.repo;

import java.util.Map;

/**
 * Spring Framework를 이용하여 RepositoryService를 초기화한다.
 */
public class RepositorySpring
{
	public void setRepositories(Map<Integer, Repository> repositories)
	{
		for (Integer key : repositories.keySet())
		{
			Repository r = repositories.get(key);
			RepositoryService.addRepository(key, r);
		}
	}

	/**
	 * 기본 Repository Type을 설정한다.
	 * @param type
	 */
	public void setDefaultRepositoryType(Integer type)
	{
		RepositoryService.setDefaultRepositoryType(type);
	}

	/**
	 * 썸네일 Repository Type을 설정한다.
	 * @param type
	 */
	public void setThumbRepositoryType(Integer type)
	{
		RepositoryService.setThumbRepositoryType(type);
	}
}
