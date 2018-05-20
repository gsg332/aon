package com.aon.lib.json;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.fasterxml.jackson.annotation.JsonView;

public class JsonViewInterceptor extends HandlerInterceptorAdapter {

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

		if (handler instanceof HandlerMethod) {
			HandlerMethod handlerMethod = (HandlerMethod) handler;
			JsonView jsonViewAnnotation = handlerMethod.getMethodAnnotation(JsonView.class);
			if (jsonViewAnnotation != null) {
				modelAndView.addObject(JsonView.class.getName(), jsonViewAnnotation.value()[0]);
			}
		}
	}

}
