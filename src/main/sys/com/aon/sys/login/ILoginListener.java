package com.aon.sys.login;

import org.springframework.context.event.EventListener;

public interface ILoginListener {

	@EventListener
	public void login(LoginEvent.Login e);

	@EventListener
	public void logout(LoginEvent.Logout e);

}
