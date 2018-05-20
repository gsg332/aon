package com.aon.module.survey.coupon;

import java.util.Date;
import java.util.HashMap;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aon.module.email.EmailService;

@Controller
@RequestMapping("/module/survey/coupon")
public class CouponUserController {

	static final Logger LOGGER = LoggerFactory.getLogger(CouponUserController.class);

	@Autowired
	private CouponQuery query;

	@Autowired
	private CouponService service;

	@Autowired
	EmailService emailService;

	@RequestMapping("/show")
	public Model showCoupon(String email, String couponNum, Model model) throws Exception {
		try {
			Long couponid = query.getCouponId(email, couponNum);
			if (couponid != null) {
				Coupon coupon = service.load(couponid);
				model.addAttribute("item", coupon);
			} else {
				model.addAttribute("error", "NoFind");
			}
			return model;
		} catch (Exception e) {
			model.addAttribute("error", "NoFind");
			return model;
		}
	}

	@RequestMapping("/create")
	public Model createCoupon(String email, Long surveyid, Model model) throws Exception {
		try {
			/*
			 * 이미 참여한 사용자인지 확인
			 */
			boolean checkUser = query.getUserId(email, surveyid) > 0 ? true : false;
			boolean checkCoupon = query.checkUser(email, surveyid);
			LOGGER.debug(checkCoupon + "");
			model.addAttribute("checkAlready", checkCoupon);
			model.addAttribute("checkUser", checkUser);

			if (checkCoupon || !checkUser) {
				return model;
			}

			/*
			 * 쿠폰 번호 생성
			 */
			final char[] possibleCharacters = { '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'A', 'B', 'C', 'D',
					'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
					'Y', 'Z' };

			final int possibleCharacterCount = possibleCharacters.length;
			Random rnd = new Random();

			boolean effectCoupon = false;
			StringBuffer buf = new StringBuffer(16);
			String couponnum = null;
			while (!effectCoupon) {

				// i는 8자리의 랜덤값을 의미
				for (int i = 8; i > 0; i--) {
					buf.append(possibleCharacters[rnd.nextInt(possibleCharacterCount)]);
				}
				couponnum = buf.toString();
				LOGGER.debug(couponnum);

				// DB에 입력되어있는 쿠폰번호인지 확인. 입력되어 있는경우 새로 만든다.
				effectCoupon = query.effectCoupon(couponnum);
			}
			model.addAttribute("couponnum", couponnum);
			model.addAttribute("email", email);
			/*
			 * DB에 저장
			 */
			Coupon coupon = service.create();
			coupon.setUserId(query.getUserId(email, surveyid));
			coupon.setSurveyId(surveyid);
			coupon.setCouponCertikey(couponnum);
			coupon.setInsertDate(new Date());
			coupon.setUse(false);

			return model;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@RequestMapping("/use")
	public Model useCoupon(String email, String couponNum, Model model) throws Exception {
		try {
			Long couponid = query.getCouponId(email, couponNum);

			if (couponid != null) {
				Coupon coupon = service.load(couponid);
				coupon.setUse(true);

				model.addAttribute("item", coupon);
			} else {
				model.addAttribute("error", "NoFind");
			}
			return model;
		} catch (Exception e) {
			model.addAttribute("error", "NoFind");
			return model;
		}
	}

	@RequestMapping("/sendEmail")
	public Model sendEmail(HttpServletRequest request, String email, String couponNum, Model model) throws Exception {
		try {
			emailService.sendEmailByCoupon(request, email, couponNum);
			model.addAttribute("status", "success");
			return model;
		} catch (Exception e) {
			model.addAttribute("status", "fail");
			return model;
		}
	}
}
