package com.aon.sys.schedule;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;


@Component
public class ScheduleVaildator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return Schedule.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		 ValidationUtils.rejectIfEmptyOrWhitespace(errors, "className", "schedule.error.className" ,"ClassName is required.");
		 ValidationUtils.rejectIfEmptyOrWhitespace(errors, "param", "schedule.error.param" ,"Param is required.");
	}

}
