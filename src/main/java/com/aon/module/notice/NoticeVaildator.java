package com.aon.module.notice;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;


@Component
public class NoticeVaildator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return Notice.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		 ValidationUtils.rejectIfEmptyOrWhitespace(errors, "title", "notice.error.title" ,"Title is required.");
		 ValidationUtils.rejectIfEmptyOrWhitespace(errors, "content", "notice.error.content" ,"Content is required.");
	}

}
