package com.aon.lib.validator;

import org.springframework.validation.BindingResult;

public class ValidationException  extends Exception{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4815686541905018874L;
	
	private BindingResult error;
	
	public ValidationException(BindingResult error){
		this.error = error;
	}
	
	public BindingResult getBindingResult(){
		return error;
	}
	
}
