package com.aon.sys.member;

import java.io.Serializable;
import java.util.Date;

import com.aon.doc.BaseJsonView;
import com.fasterxml.jackson.annotation.JsonView;

public class MemberSearch implements Serializable {

	private static final long serialVersionUID = 950096531002244230L;

	@JsonView(BaseJsonView.Summary.class)
	private String dateSearchKey;
	@JsonView(BaseJsonView.Summary.class)
	private Date startDate;
	@JsonView(BaseJsonView.Summary.class)
	private Date endDate;
	@JsonView(BaseJsonView.Summary.class)
	private String statusSearchKey;
	@JsonView(BaseJsonView.Summary.class)
	private String inputSearchKey;
	@JsonView(BaseJsonView.Summary.class)
	private String inputSearchValue;

	public String getDateSearchKey() {
		return dateSearchKey;
	}

	public void setDateSearchKey(String dateSearchKey) {
		this.dateSearchKey = dateSearchKey;
	}

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

	public String getStatusSearchKey() {
		return statusSearchKey;
	}

	public void setStatusSearchKey(String statusSearchKey) {
		this.statusSearchKey = statusSearchKey;
	}

	public String getInputSearchKey() {
		return inputSearchKey;
	}

	public void setInputSearchKey(String inputSearchKey) {
		this.inputSearchKey = inputSearchKey;
	}

	public String getInputSearchValue() {
		return inputSearchValue;
	}

	public void setInputSearchValue(String inputSearchValue) {
		this.inputSearchValue = inputSearchValue;
	}

}
