package com.aon.lib.jpa;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.transaction.annotation.Transactional;


public class TransactionFilter implements Filter
{
    Logger log = LoggerFactory.getLogger(TransactionFilter.class);

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		log.debug("TransactoinFilter initialize...");
	}

	@Override
	@Transactional
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		chain.doFilter(request, response);
	}
	
	@Override
	public void destroy() {
		log.debug("TransactionFilter destory...");
	}

}