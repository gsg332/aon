package com.aon.module.survey;

import com.aon.doc.BaseDoc;
import com.aon.doc.BaseJsonView;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.annotations.QueryEntity;

@QueryEntity
public class Survey extends BaseDoc {

	private static final long serialVersionUID = 2440779974042768143L;

	@JsonView(BaseJsonView.Summary.class)
	private Long surveyId;

	@JsonView(BaseJsonView.Summary.class)
	private String questionCode;

	@JsonView(BaseJsonView.Summary.class)
	private Long userId;

	@JsonView(BaseJsonView.Summary.class)
	private String textValue;

	@JsonView(BaseJsonView.Summary.class)
	private int numValue;

	public Long getSurveyId() {
		return surveyId;
	}

	public void setSurveyId(Long surveyId) {
		this.surveyId = surveyId;
	}

	public String getQuestionCode() {
		return questionCode;
	}

	public void setQuestionCode(String questionCode) {
		this.questionCode = questionCode;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getTextValue() {
		return textValue;
	}

	public void setTextValue(String textValue) {
		this.textValue = textValue;
	}

	public int getNumValue() {
		return numValue;
	}

	public void setNumValue(int numValue) {
		this.numValue = numValue;
	}
}
