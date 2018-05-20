package com.aon.module.survey.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SurveyUserService {
	
	@Autowired
	private ISurveyUserRepository repository;
	
	public SurveyUser create() {
		return repository.create(new SurveyUser());
	}
}
