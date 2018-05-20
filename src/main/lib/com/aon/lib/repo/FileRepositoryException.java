package com.aon.lib.repo;

/**
 * FileRepository에서 발생하는 Exception이다.
 * <p>
 * Repository의 root가 지정되어 있지 않은 경우 발생한다.
 */
public class FileRepositoryException extends Exception
{
	private static final long serialVersionUID = 4509734329886760628L;
}
