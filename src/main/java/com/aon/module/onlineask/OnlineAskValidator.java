package com.aon.module.onlineask;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.aon.module.doc.DocItem;

@Component
public class OnlineAskValidator implements Validator {

	private static final Logger LOGGER = LoggerFactory.getLogger(OnlineAskUserController.class);

	@Override
	public boolean supports(Class<?> clazz) {
		return DocItem.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		// resoure 파일 메세지 key, default message
		/*
		 * ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email",
		 * "doc.error.content", "email is required.");
		 * ValidationUtils.rejectIfEmptyOrWhitespace(errors, "content",
		 * "doc.error.content", "content is required.");
		 * ValidationUtils.rejectIfEmptyOrWhitespace(errors, "loginid",
		 * "doc.error.content", "loginid is required.");
		 * ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userName",
		 * "doc.error.content", "name is required.");
		 */
	}
}
