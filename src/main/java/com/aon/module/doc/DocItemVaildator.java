package com.aon.module.doc;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;


@Component
public class DocItemVaildator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return DocItem.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
																	//resoure 파일 메세지 key, default message 
		 ValidationUtils.rejectIfEmptyOrWhitespace(errors, "title", "doc.error.title" ,"Title is required.");
		 ValidationUtils.rejectIfEmptyOrWhitespace(errors, "content", "doc.error.content" ,"Content is required.");

	}

}
