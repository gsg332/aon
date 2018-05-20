package com.aon.doc.file;

import java.io.OutputStream;

import org.springframework.data.annotation.Transient;

import com.aon.doc.BaseJsonView;
import com.aon.doc.BaseObject;
import com.aon.lib.repo.RepositoryFile;
import com.aon.lib.repo.RepositoryService;
import com.fasterxml.jackson.annotation.JsonView;

public abstract class BaseAttachment extends BaseObject implements RepositoryFile {
	private static final long serialVersionUID = -7486034882634169578L;

	@Transient
	private Object item;
	
	@JsonView(BaseJsonView.Detail.class)
	private String filename;
	
	@JsonView(BaseJsonView.Detail.class)
	private long filesize;
	
	@JsonView(BaseJsonView.Detail.class)
	private String path;
	
	@JsonView(BaseJsonView.Detail.class)
	private Integer type;
	
	@JsonView(BaseJsonView.Detail.class)
	private String method;

	@JsonView(BaseJsonView.Detail.class)
	private int dnldCnt;
	/**
	 * 어느 문서에 첨부되어 있는지를 돌려준다.
	 */
	public Object getEntity() {
		return item;
	}

	public void setEntity(Object item) {
		this.item = item;
	}

	/**
	 * 파일명을 나타낸다.
	 */
	public String getFilename() {
		return this.filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	/**
	 * 확장자를 돌려준다.
	 * <p>
	 * 확장자가 없는 경우 파일이 없는 경우와 구분하기 위해 <code>"unknown"</code>을 돌려준다.
	 */
	public String getExtension() {
		if (this.filename == null) {
			return "unknown";
		}
		int i = this.filename.lastIndexOf('.');
		if (i < 0) {
			return "unknown";
		} else {
			String filename = this.filename.substring(i + 1);
			if (filename.length() > 8)
				return "unknown";
			return filename;
		}
	}

	/**
	 * 파일의 크기를 나타낸다. 필수적으로 설정해야 한다.
	 */
	public long getFilesize() {
		return this.filesize;
	}

	public void setFilesize(long filesize) {
		this.filesize = filesize;
	}

	/**
	 * 파일이 현재 저장되어 있는 Repository를 나타낸다.
	 */
	public Integer getType() {
		return this.type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	/**
	 * 파일이 Repository 내에 저장된 경로를 나타낸다.
	 * <p>
	 * 반드시 파일 시스템 상의 경로를 의미하지는 않는다. <code>type</code>과 함께 사용되어야 의미를 갖는다. 예를 들어,
	 * FileRepository에 저장된 경우 repository root에 대한 상대경로 값이고, Documentum에 저장된 경우
	 * object id이다.
	 */
	public String getPath() {
		return this.path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	/**
	 * upload된 파일을 저장할 방식을 돌려준다.
	 */
	public String getMethod() {
		return this.method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	/**
	 * 첨부화일의 다운로드수를 돌려준다.
	 * 
	 * @return 다운로드수
	 */
	public int getDnldCnt() {
		return this.dnldCnt;
	}

	public void setDnldCnt(int dnldCnt) {
		this.dnldCnt = dnldCnt;
	}

	/**
	 * 해당 file을 주어진 OutputStream으로 write한다.
	 */
	public void write(OutputStream os) throws Exception {
		write(os, 0);
	}

	/**
	 * 해당 file을 주어진 offset 위치 부터 OutputStream으로 write한다.
	 */
	public void write(OutputStream os, long offset) throws Exception {
		this.filesize = RepositoryService.getRepository(this.type).write(this.path, os, offset);
	}

	/**
	 * repository와 db에서 모두 삭제
	 */
	public boolean isDelete() {
		return "delete".equals(getMethod());
	}

	/**
	 * default repository에 복사한 후 db에 저장
	 */
	public boolean isCopy() {
		return "copy".equals(getMethod());
	}

	/**
	 * default repository로 이동(원래 repository에서 삭제)한 후 db에 저장
	 */
	public boolean isMove() {
		return "move".equals(getMethod());
	}

	/**
	 * default repository에 저장하지 않고 db에 현재 repository 정보를 저장
	 */
	public boolean isLink() {
		return "link".equals(getMethod());
	}

	/**
	 * Web Editor 등으로 이미 서버에 저장된 경우
	 * <p>
	 * sa_image 에 저장된 파일 정보를 복사해서 attachments에 추가하고 sa_image 에 정보는 삭제한다.
	 */
	public boolean isEditor() {
		return "editor".equals(getMethod());
	}

	/**
	 * WebEditor 에 동영상 등록 기능으로 이미 서버에 파일이 저장된 경우
	 * <p>
	 * sa_movie 에 저장된 파일 정보를 이용하고 MovieRepository 로 작동한다.
	 */
	public boolean isMovie() {
		return "movie".equals(getMethod());
	}

	/**
	 * Mime Data 에서 첨부파일을 추출해서 사용할 경우
	 */
	public boolean isMime() {
		return "mime".equals(getMethod());
	}

	public void write(String dst) throws Exception {
		RepositoryService.getRepository(this.type).write(this.path, dst);
	}
}
