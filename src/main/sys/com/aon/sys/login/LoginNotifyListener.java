package com.aon.sys.login;

import org.springframework.stereotype.Component;

import com.aon.sys.login.LoginEvent.Login;
import com.aon.sys.login.LoginEvent.Logout;

@Component
public class LoginNotifyListener implements ILoginListener {

	@Override
	public void login(Login e) {
		System.out.println("create notity");

	}

	@Override
	public void logout(Logout e) {
		System.out.println("delete notity");

	}

}
