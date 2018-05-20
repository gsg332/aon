package com.aon.module.onlineask;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.aon.doc.BaseController;
import com.aon.sys.login.LoginService;
import com.aon.sys.member.Member;
import com.aon.sys.member.MemberService;
import com.aon.sys.usr.User;
@RequestMapping(value = "/module/onlineAsk")
@Controller
public class OnlineAskUserController extends BaseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(OnlineAskUserController.class);

	@Autowired
	private OnlineAskService service;
	
	@Autowired
	private MemberService mservice;
	
	@Autowired
	private OnlineAskValidator validator;

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	@ResponseStatus(code = HttpStatus.OK)
	public void register(OnlineAsk client, BindingResult result) throws Exception {
		validator.validate(client, result);
		checkBindingResult(result);
		OnlineAsk server = service.loadOrCreate(client.getId());
		service.update(server, client);
		service.regist(server);
	}
	
	@RequestMapping(value = "/memberInfo")
	@Secured({User.ROLE_USER,User.ROLE_ADMIN,})
	public Member memberInfo() throws Exception {
		Member loginUser = null;
		if(LoginService.getSecuritySession() != null)
			loginUser = mservice.getMemberInfo();
		
		return loginUser;
	}
}
