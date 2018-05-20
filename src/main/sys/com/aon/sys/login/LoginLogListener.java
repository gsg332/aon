package com.aon.sys.login;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.aon.lib.util.NetworkUtil;
import com.aon.sys.login.LoginEvent.Login;
import com.aon.sys.login.LoginEvent.Logout;
import com.aon.sys.member.Member;
import com.aon.sys.usr.UserSecurity;

@Component
public class LoginLogListener implements ILoginListener {

	private static final Logger LOGGER = LoggerFactory.getLogger(LoginLogListener.class);

	@Autowired
	IAccessRepository repository;

	@Override
	public void login(Login e) {

		Map<String, Object> param = (HashMap<String, Object>) e.getSource();

		UserSecurity userSecurity = (UserSecurity) param.get("userSecurity");
		HttpServletRequest request = (HttpServletRequest) param.get("request");

		Member.Access access = new Member.Access();

		access.setIp(NetworkUtil.StringToLongIp(NetworkUtil.getClientIp(request)));
		access.setMemberId(userSecurity.getCustomUser().getId());
		access.setInsertDate(new Date());

		repository.save(access);

		LOGGER.info("Access Register Success");
	}

	@Override
	public void logout(Logout e) {
		LOGGER.info("Access Register Fail");
	}
}
