package com.aon.sys.certify.sms;

import java.util.Calendar;
import java.util.Date;
import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.amazonaws.services.sns.model.PublishResult;
import com.aon.sys.certify.sms.SmsCertifyException.InvalidNumberException;
import com.aon.sys.certify.sms.SmsCertifyException.InvalidParameterException;
import com.aon.sys.certify.sms.SmsCertifyException.InvalidTimeException;
import com.aon.sys.usr.UserService;

/**
 * 문자인증 Service
 */
@Service
public class SmsCertifyService {

	private static final Logger logger = LoggerFactory.getLogger(SmsCertifyService.class);

	@Autowired
	private ISmsCertifyRepository repository;
	
	@Autowired
	private AmazoneSmsService amazoneSmsService;

	/**
	 * 문자인증 발송을 처리한다.
	 *
	 * @param cellPhoneCountryCode
	 * @param cellPhoneNumber
	 * @param memberId
	 * @throws Exception
	 */
	public void send(String cellPhoneCountryCode, String cellPhoneNumber, Long memberId) throws Exception {
		if (StringUtils.isEmpty(cellPhoneCountryCode) || StringUtils.isEmpty(cellPhoneNumber)
				|| StringUtils.isEmpty(memberId)) {
			throw new InvalidParameterException();
		}

		SmsCertify smsCertify = new SmsCertify();
		smsCertify.setCellPhoneCountryCode(cellPhoneCountryCode);
		smsCertify.setCellPhoneNumber(cellPhoneNumber);
		smsCertify.setCertifyNumber(getRandomNumber(SmsCertify.CERTIFY_NUMBER_LENGTH));
		smsCertify.setResultCode(SmsCertify.WAITED);
		smsCertify.setInsertDate(new Date());
		smsCertify.setMemberId(memberId);

		PublishResult result = amazoneSmsService.send(smsCertify);
		logger.debug("##### smsCertify : {}", smsCertify.toString());
		repository.save(smsCertify);
	}

	/**
	 * 인증번호를 비교하여 결과를 돌려준다. 인증번호가 존재하면 result = true로 처리해서 재인증의 사용을 막는다.
	 *
	 * @param memberId
	 * @param certifyNumber
	 * @return
	 * @throws Exception
	 */
	public SmsCertify check(Long memberId, String certifyNumber) throws Exception {
		SmsCertify smsCertify = repository.findFirstByMemberIdAndResultCodeAndCertifyNumberOrderByIdDesc(memberId,
				SmsCertify.WAITED, certifyNumber);

		if (smsCertify != null) {
			checkTime(smsCertify);
			smsCertify.setResultCode(SmsCertify.SUCCESS);
		} else {
			throw new InvalidNumberException();
		}

		return smsCertify;
	}

	/**
	 * submit 시 client로부터 전달받은 인증일련번호(인증결과)가 유효한지 확인한다.
	 *
	 * @param id
	 * @throws Exception
	 */
	public void checkResult(Long id) throws Exception {
		SmsCertify smsCertify = repository.findOneByIdAndMemberIdAndResultCode(id, UserService.getMemberId(),
				SmsCertify.SUCCESS);
		if (smsCertify == null) {
			throw new SmsCertifyException();
		}
	}

	/**
	 * 인증번호의 유효시간을 체크한다.
	 *
	 * @param smsCertify
	 * @throws Exception
	 */
	private void checkTime(SmsCertify smsCertify) throws Exception {
		Calendar cal = Calendar.getInstance();
		cal.setTime(smsCertify.getInsertDate());
		cal.add(Calendar.MINUTE, SmsCertify.CERTIFY_EXPIRED_MINUTE);

		Calendar nowDate = Calendar.getInstance();

		if (!nowDate.before(cal)) {
			throw new InvalidTimeException();
		}
	}

	/**
	 * TODO : util class 이관
	 * 
	 * 입력값 만큼의 자릿수를 갖는 램덤번호를 생성한다.
	 *
	 * @param length
	 * @return
	 * @throws Exception
	 */
	private String getRandomNumber(int length) throws Exception {
		String str = "";
		int d = 0;

		for (int i = 1; i <= length; i++) {
			Random r = new Random();
			d = r.nextInt(9);
			str = str + Integer.toString(d);
		}

		return str;
	}
}
