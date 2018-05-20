package com.aon.lib.jpa;

import java.lang.reflect.AnnotatedElement;

import org.springframework.transaction.annotation.AnnotationTransactionAttributeSource;
import org.springframework.transaction.interceptor.DelegatingTransactionAttribute;
import org.springframework.transaction.interceptor.TransactionAttribute;

@SuppressWarnings("serial")
public class RollbackForAllAnnotationTAS extends AnnotationTransactionAttributeSource {
	@Override
	protected TransactionAttribute determineTransactionAttribute(AnnotatedElement ae) {
		TransactionAttribute target = super.determineTransactionAttribute(ae);
		if (target == null)
			return null;
		else
			return new DelegatingTransactionAttribute(target) {
				@Override
				public boolean rollbackOn(Throwable ex) {
					return true;
				}
			};
	}
}