package com.aon.module.survey.coupon;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.aon.lib.jpa.Query;
import com.aon.module.survey.user.QSurveyUser;
import com.querydsl.jpa.impl.JPAQuery;

@Service
public class CouponQuery extends Query {
	static final Logger LOGGER = LoggerFactory.getLogger(CouponQuery.class);

	public boolean checkUser(String email, Long surveyid) throws Exception {
		LOGGER.debug(email + "," + surveyid);
		QCoupon coupon = QCoupon.coupon;
		QSurveyUser user = QSurveyUser.surveyUser;
		JPAQuery<?> query = getQuery();

		query.select(coupon.id);
		query.from(coupon);
		query.leftJoin(user).on(user.id.eq(coupon.userId));
		query.where(user.email.eq(email));
		query.where(coupon.surveyId.eq(surveyid));

		if (query.fetchCount() == 0)
			return false;

		return true;
	}

	public boolean effectCoupon(String couponnum) throws Exception {
		LOGGER.debug(couponnum);
		QCoupon coupon = QCoupon.coupon;
		JPAQuery<?> query = getQuery();

		query.select(coupon.id);
		query.from(coupon);
		query.where(coupon.couponCertikey.eq(couponnum));

		if (query.fetchCount() == 0)
			return true;

		return false;
	}

	public Long getCouponId(String email, String couponnum) throws Exception {
		LOGGER.debug(email + " , " + couponnum);
		QCoupon coupon = QCoupon.coupon;
		QSurveyUser user = QSurveyUser.surveyUser;
		JPAQuery<?> query = getQuery();

		query.select(coupon.id);
		query.from(coupon);
		query.leftJoin(user).on(user.id.eq(coupon.userId));
		query.where(coupon.couponCertikey.eq(couponnum));
		query.where(user.email.eq(email));
		query.where(coupon.use.eq(false));
		return (Long) query.fetch().get(0);
	}

	public Long getUserId(String email, Long surveyid) throws Exception {
		QSurveyUser user = QSurveyUser.surveyUser;
		JPAQuery<?> query = getQuery();

		query.select(user.id);
		query.from(user);
		query.where(user.email.eq(email));
		query.where(user.surveyId.eq(surveyid));

		return (Long) query.fetch().get(0);
	}
}
