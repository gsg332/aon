package com.aon.module.survey.coupon;

import java.util.Date;

import com.aon.doc.BaseDoc;
import com.aon.doc.BaseJsonView;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.annotations.QueryEntity;

@QueryEntity
public class Coupon extends BaseDoc {
	private static final long serialVersionUID = 5386214354423322827L;

	@JsonView(BaseJsonView.Summary.class)
	private Long userId;

	@JsonView(BaseJsonView.Summary.class)
	private Long surveyId;

	@JsonView(BaseJsonView.Summary.class)
	private String couponNumber;

	@JsonView(BaseJsonView.Summary.class)
	private String couponCertikey;

	@JsonView(BaseJsonView.Summary.class)
	private Date insertDate;

	@JsonView(BaseJsonView.Summary.class)
	private boolean use;

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Long getSurveyId() {
		return surveyId;
	}

	public void setSurveyId(Long surveyId) {
		this.surveyId = surveyId;
	}

	public String getCouponNumber() {
		return couponNumber;
	}

	public void setCouponNumber(String couponNumber) {
		this.couponNumber = couponNumber;
	}

	public String getCouponCertikey() {
		return couponCertikey;
	}

	public void setCouponCertikey(String couponCertikey) {
		this.couponCertikey = couponCertikey;
	}

	public Date getInsertDate() {
		return insertDate;
	}

	public void setInsertDate(Date insertDate) {
		this.insertDate = insertDate;
	}

	public boolean isUse() {
		return use;
	}

	public void setUse(boolean use) {
		this.use = use;
	}

}
