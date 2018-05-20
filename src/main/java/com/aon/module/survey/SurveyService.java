package com.aon.module.survey;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SurveyService {

	@Autowired
	private ISurveyRepository repository;
	
	public Survey create() {
		return repository.create(new Survey());
	}
	
	public void insert(Map<String, Object> paramMap){
		String questionCode = (String) paramMap.get("questionCode");
		Survey server = this.create();
		server.setSurveyId((Long) paramMap.get("surveyId"));
		server.setQuestionCode((String) paramMap.get("questionCode"));
		server.setUserId((Long) paramMap.get("userId"));
		
		if(questionCode.indexOf("text") == -1 && questionCode.indexOf("_csrf") == -1 && questionCode.indexOf("surveyId") == -1 && questionCode.indexOf("userId") == -1){
			server.setNumValue((int) paramMap.get("value"));
		}
		if(questionCode.indexOf("text") != -1){
			server.setTextValue((String) paramMap.get("textValue"));
		}
	}
}
