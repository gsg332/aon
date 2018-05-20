package com.aon.lib.repo;

import java.io.OutputStream;

/**
 * 파일의 저장소이다.
 */
public interface Repository
{
	/**
	 * 파일을 Repository에 복사하고, 복사된 경로를 돌려준다.
	 * 
	 * @return 저장된 경로
	 */
	public String store(RepositoryFile file) throws Exception;

	/**
	 * 저장된 파일을 주어진 OutputStream으로 출력한다.
	 * <p>
	 * 내부적으로 생성한 임시파일이 있다면 반드시 삭제해야 한다.
	 * 
	 * @param os 출력할 OutputStream. 닫지 않는다.
	 * 
	 * @return 복사된 byte 크기를 돌려준다.
	 */
	public long write(String path, OutputStream os) throws Exception;

    /**
     * 저장된 파일을 주어진 offset 위치 부터 OutputStream으로 출력한다.
     * <p>
     * 부분 출력, 이어받기 에 사용한다.
     */
    public long write(String path, OutputStream os, long offset) throws Exception;
    
	/**
	 * 주어진 정보의 위치에 있는 파일을 삭제한다.
	 */
	public void delete(String path) throws Exception;

	/**
	 * @param path
	 * @param dest
	 */
	public long write(String path, String dest) throws Exception;

}
