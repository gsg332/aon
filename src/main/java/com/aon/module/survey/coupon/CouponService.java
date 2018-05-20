package com.aon.module.survey.coupon;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CouponService {

	@Autowired
	private ICouponRepository repository;

	public Coupon load(Long id) {
		return repository.loadWithLock(id);
	}

	public Coupon create() {
		return repository.create(new Coupon());
	}
}
