package com.aon.module.survey;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.aon.lib.jpa.Query;
import com.aon.module.survey.user.QSurveyUser;
import com.querydsl.jpa.impl.JPAQuery;

@Service
public class SurveyQuery extends Query {
	
	public void insertSurvey(Map<String, Object> paramMap) throws Exception {
		
		String questionCode = (String) paramMap.get("questionCode");
		if(questionCode.indexOf("text") == -1 && questionCode.indexOf("_csrf") == -1 && questionCode.indexOf("surveyId") == -1 && questionCode.indexOf("userId") == -1){
			String query = "insert into survey_answer (survey_id, question_code, user_id, text_value, number_value, insert_date)"
					+ " values (?, ?, ?, ?, ?, sysdate())";
			createNativeQuery(query).setParameter(1, paramMap.get("surveyId"))
			.setParameter(2, paramMap.get("questionCode"))
			.setParameter(3, paramMap.get("userId"))
			.setParameter(4, paramMap.get("textValue"))
			.setParameter(5, paramMap.get("value"))
			.executeUpdate();
		}
	}
	
	public boolean joincheck(String email, Long surveyId) throws Exception{
		QSurveyUser user = QSurveyUser.surveyUser;
		JPAQuery<?> query = getQuery();

		query.select(user.id);
		query.from(user);
		query.where(user.email.eq(email));
		query.where(user.surveyId.eq(surveyId));
		if(query.fetchCount()>0)
			return true;
		
		return false;		
	}
}
