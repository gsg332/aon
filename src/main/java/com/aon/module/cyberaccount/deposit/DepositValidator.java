package com.aon.module.cyberaccount.deposit;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class DepositValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return Deposit.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "requestPoint", "deposit.error.requestPoint",
				"Insert the charge points.");
		// ValidationUtils.rejectIfEmptyOrWhitespace(errors, "requestAccountName", "deposit.error.requestAccountName",
		// "Enter your name.");
		// ValidationUtils.rejectIfEmptyOrWhitespace(errors, "requestDate", "deposit.error.requestDate", "Enter the
		// deposit date.");
	}

	public void validateConfirmAdmin(Object target, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "confirmPoint", "deposit.error.confirmPoint",
				"Insert the amount.");
	}

	public void validateDepositAdmin(Object client, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "confirmPoint", "deposit.error.confirmPoint",
				"Insert the amount.");
	}

}
