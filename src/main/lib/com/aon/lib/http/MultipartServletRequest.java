package com.aon.lib.http;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.util.MultiValueMap;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.support.DefaultMultipartHttpServletRequest;

import com.navercorp.lucy.security.xss.servletfilter.XssEscapeFilter;

public class MultipartServletRequest extends DefaultMultipartHttpServletRequest{

	private XssEscapeFilter filter =  XssEscapeFilter.getInstance();
	private String path;
	
	public MultipartServletRequest(HttpServletRequest request) {
		super(request);
		this.path = request.getRequestURI();
	}

	public MultipartServletRequest(HttpServletRequest request, MultiValueMap<String, MultipartFile> mpFiles,
			Map<String, String[]> mpParams, Map<String, String> mpParamContentTypes) {

		super(request);
		setMultipartFiles(mpFiles);
		setMultipartParameters(mpParams);
		setMultipartParameterContentTypes(mpParamContentTypes);
		this.path = request.getRequestURI();

	}
	@Override
	public String getParameter(String name) {
		return filter.doFilter(path, name, super.getParameter(name));
	}

	@Override
	public String[] getParameterValues(String name) {
		String values[] = super.getParameterValues(name);
		if (values == null) {
			return values;
		}
		for (int index = 0; index < values.length; index++) {
			values[index] = filter.doFilter(path, name, values[index]);
		}
		return values;
	}

	
}
