package com.aon.sys.schedule.log;

import java.util.Date;

import com.aon.doc.BaseJsonView;
import com.aon.doc.BaseObject;
import com.aon.lib.util.NetworkUtil;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.annotations.QueryEntity;

@QueryEntity
public class SysLog extends BaseObject {

	private static final long serialVersionUID = -3857785976996995632L;

	@JsonView(BaseJsonView.Summary.class)
	private String name;
	
	@JsonView(BaseJsonView.Summary.class)
	private String param;
	
	@JsonView(BaseJsonView.Summary.class)
	private String detail;
	
	@JsonView(BaseJsonView.Summary.class)
	private Date insertDate;
	
	@JsonView(BaseJsonView.Summary.class)
	private boolean result;
	
	@JsonView(BaseJsonView.Summary.class)
	private long ip;

	/**
	 * 로그를 남긴 주체를 돌려준다.
	 */
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	/**
	 * 로그를 남기고자 하는 정보를 돌려준다.
	 */
	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		if (param != null && param.length() > 1000) {
			this.param = param.substring(0, 1000);
		} else {
			this.param = param;
		}
	}

	/**
	 * 로그를 남기고자 하는 상세 정보를 돌려준다.
	 */
	public String getDetail() {
		return this.detail;
	}

	public void setDetail(String detail) {
		if (detail != null && detail.length() > 1000) {
			this.detail = detail.substring(0, 1000);
		} else {
			this.detail = detail;
		}
	}

	/**
	 * 로그를 남긴 시각을 돌려준다.
	 */
	public Date getInsertDate() {
		return insertDate;
	}

	public void setInsertDate(Date insertDate) {
		this.insertDate = insertDate;
	}

	/**
	 * 성공/실패 등의 상태를 돌려준다.
	 */

	public boolean isResult() {
		return result;
	}

	public void setResult(boolean result) {
		this.result = result;
	}

	/**
	 * 스케줄을 수행한 서버 ip
	 * 
	 * @return
	 */
	public long getIp() {
		return ip;
	}

	public void setIp(long ip) {
		this.ip = ip;
	}

	@JsonView(BaseJsonView.Summary.class)
	public String getIpAddress() {
		Long ip = getIp();
		if (ip != null) {
			return NetworkUtil.longToStringIp(getIp());
		}
		return null;
	}

}
