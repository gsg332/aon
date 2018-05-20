package com.aon.module.contest;

import java.io.Serializable;
import java.util.Date;

import com.aon.doc.BaseJsonView;
import com.fasterxml.jackson.annotation.JsonView;

public class ContestSearch implements Serializable {

	private static final long serialVersionUID = 8218414366421807843L;

	@JsonView(BaseJsonView.Summary.class)
	private Date startDate;

	@JsonView(BaseJsonView.Summary.class)
	private Date endDate;

	@JsonView(BaseJsonView.Summary.class)
	private Long searchPoint;

	@JsonView(BaseJsonView.Summary.class)
	private int searchChoose;

	@JsonView(BaseJsonView.Summary.class)
	private int searchStatus;

	@JsonView(BaseJsonView.Summary.class)
	private Long categoryId;

	@JsonView(BaseJsonView.Summary.class)
	private Long categorySub;
	
	@JsonView(BaseJsonView.Summary.class)
	private String searchKey;

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

	public Long getSearchPoint() {
		return searchPoint;
	}

	public void setSearchPoint(Long searchPoint) {
		this.searchPoint = searchPoint;
	}

	public int getSearchChoose() {
		return searchChoose;
	}

	public void setSearchChoose(int searchChoose) {
		this.searchChoose = searchChoose;
	}

	public int getSearchStatus() {
		return searchStatus;
	}

	public void setSearchStatus(int searchStatus) {
		this.searchStatus = searchStatus;
	}

	public Long getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}

	public Long getCategorySub() {
		return categorySub;
	}

	public void setCategorySub(Long categorySub) {
		this.categorySub = categorySub;
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

	@Override
	public String toString() {
		return "ContestSearch [startDate=" + startDate + ", endDate=" + endDate + ", searchPoint=" + searchPoint
				+ ", searchChoose=" + searchChoose + ", searchStatus=" + searchStatus + ", categoryId=" + categoryId + ", categorySub=" + categorySub
				+ ", searchKey=" + searchKey + ", searchText=" + searchText + "]";
	}
	
	
}
