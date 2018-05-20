package com.aon.lib.repo;

import java.io.OutputStream;

/**
 * Repository에 저장할 파일을 나타낸다.
 */
public interface RepositoryFile
{

	/**
	 * 파일명을 돌려준다.
	 */
	public String getFilename();

	/**
	 * 파일의 크기를 byte 단위로 돌려준다.
	 */
	public long getFilesize();

	/**
	 * 파일을 OutputStream으로 출력한다.
	 */
	public void write(OutputStream os) throws Exception;

	/**
	 * 파일을 주어진 offset 위치부터 OutputStream 으로 출력한다.
	 * <p>
	 * 부분 출력, 이어받기시 사용
	 */
	public void write(OutputStream os, long offset) throws Exception;

	/**
	 * 파일을 copy한다.
	 */
	public void write(String dst) throws Exception;

}
