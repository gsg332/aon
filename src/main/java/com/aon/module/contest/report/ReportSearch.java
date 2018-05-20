package com.aon.module.contest.report;

import java.io.Serializable;
import java.util.Date;

import com.aon.doc.BaseJsonView;
import com.fasterxml.jackson.annotation.JsonView;

/**
 * 검색 용
 * 
 * @author 이재영
 *
 */
public class ReportSearch implements Serializable {

	private static final long serialVersionUID = 3984935517035250563L;

	/**
	 * 검색 시작일
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Date startDate;

	/**
	 * 검색 종료일
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Date endDate;

	/**
	 * 검색 키
	 */
	@JsonView(BaseJsonView.Summary.class)
	private String searchKey;

	/**
	 * 검색 값
	 */
	@JsonView(BaseJsonView.Summary.class)
	private String searchText;

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getSearchKey() {
		return searchKey;
	}

	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}

	public String getSearchText() {
		return searchText;
	}

	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}

}
