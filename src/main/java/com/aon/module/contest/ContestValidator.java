package com.aon.module.contest;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class ContestValidator implements Validator {
	@Override
	public boolean supports(Class<?> clazz) {
		return Contest.class.isAssignableFrom(clazz);
	}
	
	@Override
	public void validate(Object target, Errors errors) {
		 ValidationUtils.rejectIfEmptyOrWhitespace(errors, "title", "cts.error.title" ,"Title is required.");
		 ValidationUtils.rejectIfEmptyOrWhitespace(errors, "content", "cts.error.content" ,"Content is required.");
	}
}
