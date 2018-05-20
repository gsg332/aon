package com.aon.module.cyberaccount.withdraw;

import java.io.Serializable;
import java.util.Date;

import com.aon.doc.BaseJsonView;
import com.fasterxml.jackson.annotation.JsonView;

public class WithdrawSearch implements Serializable {

	private static final long serialVersionUID = -4531420695251830656L;
	
	@JsonView(BaseJsonView.Summary.class)
	private String dateSearchKey;

	@JsonView(BaseJsonView.Summary.class)
	private Date startDate;

	@JsonView(BaseJsonView.Summary.class)
	private Date endDate;

	@JsonView(BaseJsonView.Summary.class)
	private Long searchPoint;

	@JsonView(BaseJsonView.Summary.class)
	private String memberSearchKey;

	@JsonView(BaseJsonView.Summary.class)
	private String memberSearchValue;

	/**
	 * @return the dateSearchKey
	 */
	public String getDateSearchKey() {
		return dateSearchKey;
	}

	/**
	 * @param dateSearchKey
	 *            the dateSearchKey to set
	 */
	public void setDateSearchKey(String dateSearchKey) {
		this.dateSearchKey = dateSearchKey;
	}

	/**
	 * @return the startDate
	 */
	public Date getStartDate() {
		return startDate;
	}

	/**
	 * @param startDate
	 *            the startDate to set
	 */
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	/**
	 * @return the endDate
	 */
	public Date getEndDate() {
		return endDate;
	}

	/**
	 * @param endDate
	 *            the endDate to set
	 */
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	/**
	 * @return the searchPoint
	 */
	public Long getSearchPoint() {
		return searchPoint;
	}

	/**
	 * @param searchPoint
	 *            the searchPoint to set
	 */
	public void setSearchPoint(Long searchPoint) {
		this.searchPoint = searchPoint;
	}

	/**
	 * @return the memberSearchKey
	 */
	public String getMemberSearchKey() {
		return memberSearchKey;
	}

	/**
	 * @param memberSearchKey
	 *            the memberSearchKey to set
	 */
	public void setMemberSearchKey(String memberSearchKey) {
		this.memberSearchKey = memberSearchKey;
	}

	/**
	 * @return the memberSearchValue
	 */
	public String getMemberSearchValue() {
		return memberSearchValue;
	}

	/**
	 * @param memberSearchValue
	 *            the memberSearchValue to set
	 */
	public void setMemberSearchValue(String memberSearchValue) {
		this.memberSearchValue = memberSearchValue;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "DepositSearch [dateSearchKey=" + dateSearchKey + ", startDate=" + startDate + ", endDate=" + endDate
				+ ", searchPoint=" + searchPoint + ", memberSearchKey=" + memberSearchKey + ", memberSearchValue="
				+ memberSearchValue + "]";
	}

}
