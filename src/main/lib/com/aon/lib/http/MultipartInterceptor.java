package com.aon.lib.http;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;



public class MultipartInterceptor extends HandlerInterceptorAdapter{

	MultipartContext ctx = null;
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		if (request instanceof MultipartServletRequest)
		{
			ctx =  MultipartContext.getMultipartContext();
			ctx.activate((MultipartServletRequest)request, response);
		}
		return true;
		
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		if(ctx != null){
			ctx.passivate();
			ctx = null;
		}

	}
	
	

 
}
