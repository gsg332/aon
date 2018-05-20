package com.aon.sys.upload;

import java.io.OutputStream;

import com.aon.doc.BaseObject;
import com.aon.lib.repo.RepositoryFile;
import com.aon.lib.repo.RepositoryService;

public class Upload extends BaseObject implements RepositoryFile {
	private static final long serialVersionUID = 9100922664660749394L;

	private String path;
	private Integer type;
	private String filename;
	private long filesize;
	private String method;

	/**
	 * upload된 파일을 저장할 방식을 돌려준다.
	 */
	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	/**
	 * 업로드파일의 저장 경로를 돌려준다.
	 */
	public String getPath() {
		return this.path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	/**
	 * 업로드파일의 저장 방식을 돌려준다.
	 */
	public Integer getType() {
		return this.type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	/**
	 * 업로드파일 이름을 돌려준다.
	 */
	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	/**
	 * 업로드파일 크기를 돌려준다.
	 */
	public long getFilesize() {
		return filesize;
	}

	public void setFilesize(long filesize) {
		this.filesize = filesize;
	}

	boolean isCopy() {
		return "copy".equals(getMethod());
	}

	/**
	 * 해당 파일을 OutputStream으로 write한다.
	 */
	public void write(OutputStream os) throws Exception {
		RepositoryService.getRepository(type).write(path, os);
	}

	public void write(OutputStream os, long offset) throws Exception {
		RepositoryService.getRepository(type).write(path, os, offset);
	}

	public void write(String dst) throws Exception {
		RepositoryService.getRepository(type).write(path, dst);
	}

}