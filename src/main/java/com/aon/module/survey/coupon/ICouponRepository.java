package com.aon.module.survey.coupon;

import org.springframework.stereotype.Repository;

import com.aon.doc.IBaseRepository;

@Repository
public interface ICouponRepository  extends IBaseRepository<Coupon, Long> {

}
