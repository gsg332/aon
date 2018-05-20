package com.aon.sys.certify.sms;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;

import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.sns.AmazonSNSClient;
import com.amazonaws.services.sns.model.PublishRequest;
import com.amazonaws.services.sns.model.PublishResult;
import com.aon.sys.conf.ConfigService;

@Service
public class AmazoneSmsService {

	private static final Logger logger = LoggerFactory.getLogger(AmazoneSmsService.class);

	private static SmsCertifyConfig smsCertifyConfig = (SmsCertifyConfig) ConfigService
			.getConfig(SmsCertifyConfig.class);

	private static final String SMS_MESSAGE = "[Whatinfo] Verification code : ";

	@Autowired
	private MessageSource messageSource;

	public PublishResult send(SmsCertify smsCertify) throws Exception {
		BasicAWSCredentials awsCredentials = new BasicAWSCredentials(smsCertifyConfig.getAwsAccessKey(),
				smsCertifyConfig.getAwsSecretKey());
		AmazonSNSClient snsClient = new AmazonSNSClient(awsCredentials);

		Locale locale = LocaleContextHolder.getLocale();
		String smsMessage = messageSource.getMessage("sys.msg.010", null, SMS_MESSAGE, locale);

		String message = smsMessage + smsCertify.getCertifyNumber();
		String phoneNumber = smsCertify.getCellPhoneCountryCode() + smsCertify.getCellPhoneNumber();

		return sendSMSMessage(snsClient, message, phoneNumber);
	}

	public PublishResult sendSMSMessage(AmazonSNSClient snsClient, String message, String phoneNumber)
			throws Exception {
		PublishResult result = snsClient
				.publish(new PublishRequest().withMessage(message).withPhoneNumber(phoneNumber));
		logger.debug("##### sendSMS result : {}", result);
		return result;
	}
}
