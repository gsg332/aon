package com.aon.module.survey;

import org.springframework.stereotype.Repository;

import com.aon.doc.IBaseRepository;

@Repository
public  interface ISurveyRepository extends IBaseRepository<Survey, Long>{
	
}

