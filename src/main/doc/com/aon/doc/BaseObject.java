package com.aon.doc;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonView;

public abstract class BaseObject implements Comparable<Object>, Serializable {

	private static final long serialVersionUID = 1482467310702077880L;
	
	/**
	 * 신청중상태, HR(가입중) 
	 */
	public static final int APPLIED_STATUS = 1000;
	
	/**
	 * 재신청중상태 ,HR(재가입)
	 */
	public static final int REAPPLIED_STATUS = 1100;
	
	/**
	 * 등록 상태,HR인경우는 정상 
	 */
	public static final int REGISTERED_STATUS = 2000;

	/**
	 * 삭제 신청이 있는 경우 삭제(9000으로-변경) 한다. 
	 */
	public static final int DELETED_APPLY = 8000;
	/**
	 * 삭제 상태,HR인경우는 탈퇴 
	 * DB삭제를 실제하는 경우는 Remove라는 용어로 통
	 */
	public static final int DELETED_STATUS = 9000;

	public static final int ORPHAN_FLAG = 0x0040;
	
	
	@JsonView(BaseJsonView.Summary.class)
	private Long id;
	
	@JsonView(BaseJsonView.Summary.class)
	private int version;
	
	
	
	/**
	 * id를 돌려준다.
	 * 
	 * @return 객체의 primary key
	 */
	public Long getId() {
		return this.id;
	}

	/**
	 * id를 설정한다.
	 * 
	 * @param id
	 *            객체의 primary key
	 */
	public void setId(Long id) {
		this.id = id;
	}
	
	public int getVersion() {
		return this.version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public boolean equals(Object obj) {
		if (this.id == null || !(this.getClass().isInstance(obj))) {
			return super.equals(obj);
		}
		return this.id.equals(((BaseObject) obj).getId());
	}

	public int hashCode() {
		if (this.id == null) {
			return super.hashCode();
		}
		return this.id.hashCode();
	}

	public int compareTo(Object obj) {
		if (this.id == null) {
			return 1;
		}
		Long id = ((BaseObject) obj).getId();
		if (id == null) {
			return -1;
		}
		return this.id.compareTo(id);
	}
	
	public void checkVersion(int version) throws ObjectInvaildException{
		if(this.version != version)
			throw new ObjectInvaildException();
	}
	
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}
}
