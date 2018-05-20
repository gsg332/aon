package com.aon.sys.member;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class MemberValidator implements Validator {
	
	@Override
	public boolean supports(Class<?> clazz) {
		return Member.class.isAssignableFrom(clazz);
	}
	/**
	 * 회원가입 validate
	 */
	@Override
	public void validate(Object target, Errors errors) {	
		
		Member member = (Member) target;
		
		//resoure 파일 메세지 key, default message
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "nickname", "member.error.nickname" ,"nickname is required."); 
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "firstName", "member.error.firstname" ,"lastname is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lastName", "member.error.lastname" ,"firstname is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "countryCode", "member.error.countryCode" ,"countryCode is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lastName", "member.error.lastname" ,"firstname is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "cellPhoneCountryCode", "member.error.cellPhoneCountryCode" ,"cellPhoneCountryCode is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "cellPhoneNumber", "member.error.cellPhoneNumber" ,"cellPhoneNumber is required.");

		if("3100".equals(member.getType())){ //기업 회원일 경우.
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "companyNumber", "member.error.companyNumber" ,"companyNumber is required.");
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "companyName", "member.error.companyName" ,"companyName is required.");
		}
	}
	
	/**
	 * mypage validate
	 * @param target
	 * @param errors
	 */
	public void myPageValidate(Object target, Errors errors){
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "nickname", "member.error.nickname" ,"nickname is required."); 
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "firstName", "member.error.firstname" ,"firstname is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lastName", "member.error.lastname" ,"lastname is required.");
	}
	
	/**
	 * 관리자 화면에서 회원정보를 수정할 경우 벨리데이터 체크.
	 *
	 * @param target
	 * @param errors
	 */
	public void supervisorValidate(Object target, Errors errors){
		
		Member member = (Member) target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "nickname", "member.error.nickname" ,"nickname is required."); 
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "firstName", "member.error.firstname" ,"lastname is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lastName", "member.error.lastname" ,"firstname is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "countryCode", "member.error.countryCode" ,"countryCode is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lastName", "member.error.lastname" ,"firstname is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "cellPhoneCountryCode", "member.error.cellPhoneCountryCode" ,"cellPhoneCountryCode is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "cellPhoneNumber", "member.error.cellPhoneNumber" ,"cellPhoneNumber is required.");

		if("3100".equals(member.getType())){ //기업 회원일 경우.
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "companyNumber", "member.error.companyNumber" ,"companyNumber is required.");
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "companyName", "member.error.companyName" ,"companyName is required.");
		}
	}
}
