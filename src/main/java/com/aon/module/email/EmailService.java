package com.aon.module.email;

import java.util.HashMap;
import java.util.Locale;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.context.MessageSourceAware;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.ui.velocity.VelocityEngineUtils;
import org.springframework.web.servlet.view.velocity.VelocityConfig;

import com.aon.sys.member.Member;
import com.aon.sys.member.MemberService;

@Service
public class EmailService implements MessageSourceAware {

	static final Logger LOGGER = LoggerFactory.getLogger(EmailService.class);

	@Autowired
	VelocityConfig velocityConfig;
	
	@Autowired
	MemberService memberSerivce;
	
	@Value("email-smtp.us-west-2.amazonaws.com")
	String host;
	@Value("smtp")
	String protocol;
	@Value("25")
	String port;
	@Value("AKIAJ3PRVB4SZHCCYFQQ")
	String username;
	@Value("AmuIKETUNpea5MXFV9FkIKmJygYDPfmoMifkoERp42A8")
	String password;
	@Value("true")
	String starttlsEnable;
	@Value("true")
	String starttlsRequired;
	@Value("true")
	String auth;
	@Value("WhatInfo")
	String senderName;
	@Value("minkus@aonkorea.com")
	String sendEmail;

	MessageSource messageSource;

	/**
	 * 회원에게 이메일을 발송한다.
	 *
	 * @param request
	 * @param member
	 * @param appliedStatus
	 * @return
	 * @throws Exception
	 */
	// @Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public void sendEmailToMember(HttpServletRequest request, Member client, int appliedStatus, int rndNum, String joinAuthToken) throws Exception {

		Properties props = System.getProperties();
		props.put("mail.transport.protocol", protocol);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", auth);
		props.put("mail.smtp.starttls.enable", starttlsEnable);
		props.put("mail.smtp.starttls.required", starttlsRequired);

		Session session = Session.getDefaultInstance(props);
		MimeMessage msg = new MimeMessage(session);

		Locale locale = LocaleContextHolder.getLocale();

		InternetAddress from = new InternetAddress(sendEmail, senderName, "UTF-8");
		InternetAddress to = new InternetAddress(client.getLoginId()); // 수신자 주소 생성
		msg.setFrom(from); // 송신자 설정
		msg.setRecipient(Message.RecipientType.TO, to); // 수신자 설정
		msg.setSentDate(new java.util.Date()); // 보내는 날짜 설정
		Transport transport = session.getTransport();
		
		String title = messageSource.getMessage("email.fnd.001", null, locale);
		msg.setSubject(title); // 제목 설정
		
		//메일 데이터 생성
		HashMap<String, Object> map = emailFormMake(request, client, appliedStatus, rndNum, locale, joinAuthToken);
		
		//메일 폼을 지정한다
		String mailForm = "";
		if(appliedStatus == Member.APPLIED_STATUS){
			mailForm = "mail_ok.vm";
		}else if(appliedStatus == Member.REAPPLIED_STATUS){
			mailForm = "mail_ok_re.vm";
		}else if(appliedStatus == Member.REGISTERED_STATUS){
			mailForm = "findPassword.vm";
		}
		
		String content = VelocityEngineUtils.mergeTemplateIntoString(velocityConfig.getVelocityEngine(), mailForm , "UTF-8", map);
		msg.setContent(content, "text/html;charset=utf-8");

		transport.connect(host, username, password);
		transport.sendMessage(msg, msg.getAllRecipients());
		transport.close();
		
		LOGGER.info("##### Email Send Success #####");
		LOGGER.info("##### Send Email address : " + client.getLoginId());
	}

	@Override
	public void setMessageSource(MessageSource messageSource) {
		this.messageSource = messageSource;
	}
	
	public HashMap<String, Object> emailFormMake(HttpServletRequest request, Object obj, int appliedStatus, int rndNum, Locale locale, String joinAuthToken) throws Exception{
		HashMap<String, Object> map = new HashMap<>();
		
		String authUrl;
		String emailTitle;
		String emailContent;
		String emailConfirmBtn;
		String emailReJoin;
		String tempPasswordStr;
		
		String phone = messageSource.getMessage("email.fnd.005", null, locale);
		String address = messageSource.getMessage("email.fnd.006", null, locale);
		String contextUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
		
		if (appliedStatus == Member.APPLIED_STATUS){
			authUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/sys/member/"+joinAuthToken+"/emailConfirm.aon";
			emailTitle = messageSource.getMessage("email.fnd.002", null, locale);
			emailContent = messageSource.getMessage("email.fnd.003", null, locale);
			emailConfirmBtn = messageSource.getMessage("email.fnd.004", null, locale);
			
			map.put("emailTitle", emailTitle);
			map.put("emailContent", emailContent);
			map.put("emailConfirmBtn", emailConfirmBtn);
			map.put("authUrl", authUrl);
		
		}else if(appliedStatus == Member.REAPPLIED_STATUS){
			authUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ request.getContextPath() + "/sys/member/"+joinAuthToken+"/emailConfirm.aon";
			
			emailTitle = messageSource.getMessage("email.fnd.002", null, locale);
			emailReJoin = messageSource.getMessage("email.fnd.007", null, locale);
			emailContent = messageSource.getMessage("email.fnd.008", null, locale);
			emailConfirmBtn = messageSource.getMessage("email.fnd.009", null, locale);
			
			map.put("emailTitle", emailTitle);
			map.put("emailReJoin", emailReJoin);
			map.put("emailContent", emailContent);
			map.put("emailConfirmBtn", emailConfirmBtn);
			map.put("authUrl", authUrl);
		
		}else if(appliedStatus == Member.REGISTERED_STATUS){
			Member member = (Member)obj;
			
			emailTitle = messageSource.getMessage("email.fnd.012", null, locale);
			emailContent = messageSource.getMessage("email.fnd.013", new String[] { member.getFirstName() + " " + member.getLastName() }, locale);
			tempPasswordStr = messageSource.getMessage("email.fnd.014", null, locale);
			
			map.put("emailTitle", emailTitle);
			map.put("emailContent", emailContent);
			map.put("tempPasswordStr",tempPasswordStr);
			map.put("tempPassword", rndNum);
		}
		
		map.put("phone",phone);
		map.put("address",address);
		map.put("contextUrl",contextUrl);
		
		return map;
	}
	
	public void sendEmailByCoupon(HttpServletRequest request, String email, String couponNum) throws Exception {		
		Properties props = System.getProperties();
		props.put("mail.transport.protocol", protocol);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", auth);
		props.put("mail.smtp.starttls.enable", starttlsEnable);
		props.put("mail.smtp.starttls.required", starttlsRequired);

		Session session = Session.getDefaultInstance(props);
		MimeMessage msg = new MimeMessage(session);
		Locale locale = LocaleContextHolder.getLocale();
		
		InternetAddress from = new InternetAddress(sendEmail, senderName, "UTF-8");
		InternetAddress to = new InternetAddress(email); // 수신자 주소 생성
		msg.setFrom(from); // 송신자 설정
		msg.setRecipient(Message.RecipientType.TO, to); // 수신자 설정
		msg.setSentDate(new java.util.Date()); // 보내는 날짜 설정
		
		Transport transport = session.getTransport();
		
		HashMap<String, Object> map = new HashMap<>();
		String couponUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/module/survey/coupon/index.aon#/show/"+email+"/"+couponNum;
		System.out.println(couponUrl);
		map.put("couponurl", couponUrl);
		
		String title = messageSource.getMessage("email.fnd.001", null, locale);
		msg.setSubject(title); // 제목 설정
		
		String content = VelocityEngineUtils.mergeTemplateIntoString(velocityConfig.getVelocityEngine(), "coupon.vm" , "UTF-8", map);
		msg.setContent(content, "text/html;charset=utf-8");
		
		transport.connect(host, username, password);
		transport.sendMessage(msg, msg.getAllRecipients());
		transport.close();
	}
}
