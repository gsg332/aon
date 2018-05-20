package com.aon.lib.http;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartException;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

public class MultipartResolver extends CommonsMultipartResolver{

	private boolean resolveLazily = false;
	
	public void setResolveLazily(boolean resolveLazily) {
		this.resolveLazily = resolveLazily;
		super.setResolveLazily(resolveLazily);
	}
	public MultipartHttpServletRequest resolveMultipart(final HttpServletRequest request) throws MultipartException {
		if (this.resolveLazily) {
			return new  MultipartServletRequest(request) {
				@Override
				protected void initializeMultipart() {
					MultipartParsingResult parsingResult = parseRequest(request);
					setMultipartFiles(parsingResult.getMultipartFiles());
					setMultipartParameters(parsingResult.getMultipartParameters());
					setMultipartParameterContentTypes(parsingResult.getMultipartParameterContentTypes());
				}
			};
		}
		else {
			MultipartParsingResult parsingResult = parseRequest(request);
			return new MultipartServletRequest(request, parsingResult.getMultipartFiles(),
					parsingResult.getMultipartParameters(), parsingResult.getMultipartParameterContentTypes());
		}
	}
}
