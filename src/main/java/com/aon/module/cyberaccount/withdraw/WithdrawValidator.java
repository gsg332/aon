package com.aon.module.cyberaccount.withdraw;

import org.springframework.stereotype.Component;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class WithdrawValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return Withdraw.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "requestPoint", "withdraw.error.requestPoint",
				"Please enter the requested amount.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "paypalAccount", "withdraw.error.paypalAccount",
				"Please enter the paypal account.");
		// TODO : SMS 인증 활성화시 적용.
		// ValidationUtils.rejectIfEmptyOrWhitespace(errors, "certifyId", "withdraw.error.certifyId", "Certification is required.");
	}
	
	public void validateAdmin(Object target, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "confirmPoint", "withdrawAdmin.error.confirmPoint", "Insert the withdraw amount.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "confirmDate", "withdrawAdmin.error.confirmDate", "Enter the withdraw date.");
	}

	public void validateWithdrawAdmin(Withdraw client, BindingResult errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "confirmPoint", "withdrawAdmin.error.confirmPoint", "Insert the withdraw amount.");
	}

}
