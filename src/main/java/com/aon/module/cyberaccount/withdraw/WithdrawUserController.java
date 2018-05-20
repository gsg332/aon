package com.aon.module.cyberaccount.withdraw;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.aon.doc.BaseController;
import com.aon.sys.certify.sms.SmsCertify;
import com.aon.sys.certify.sms.SmsCertifyService;
import com.aon.sys.member.Member;
import com.aon.sys.member.MemberService;
import com.aon.sys.usr.UserService;

/**
 * 출금신청
 *
 */
@Controller
@RequestMapping("/module/withdraw")
public class WithdrawUserController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(WithdrawUserController.class);

	@Autowired
	private WithdrawService service;

	@Autowired
	private MemberService memberService;

	@Autowired
	private SmsCertifyService smsCertifyService;

	@Autowired
	private WithdrawValidator validator;

	/**
	 * 출금신청을 등록한다.
	 *
	 * @param client
	 * @param result
	 * @throws Exception
	 */
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	@ResponseStatus(code = HttpStatus.OK)
	public void register(Withdraw client, BindingResult result) throws Exception {
		logger.debug("##### withdraw client : {}", client.toString());
		validator.validate(client, result);
		checkBindingResult(result);

		service.register(client);
	}

	/**
	 * 인증번호를 발송 요청 처리.
	 *
	 * @throws Exception
	 */
	@RequestMapping(value = "/sendSms")
	@ResponseStatus(code = HttpStatus.OK)
	public Model sendSms(Model model) throws Exception {
		Member member = memberService.getMemberInfo();
		smsCertifyService.send(member.getCellPhoneCountryCode(), member.getCellPhoneNumber(), member.getId());
		
		model.addAttribute("result", true);
		
		return model;
	}
	
	/**
	 * 인증번호가 유효한지 체크한다.
	 *
	 * @param certifyNumber
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/checkCertifyNumber")
	@ResponseStatus(code = HttpStatus.OK)
	public Model checkCertifyNumber(String certifyNumber, Model model) throws Exception {
		SmsCertify smsCertify = smsCertifyService.check(UserService.getMemberId(), certifyNumber);
		model.addAttribute("result", smsCertify);
		
		return model;
	}
}
