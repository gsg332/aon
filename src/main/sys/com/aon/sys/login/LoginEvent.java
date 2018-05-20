package com.aon.sys.login;

import com.aon.lib.event.Event;

@SuppressWarnings("serial")
public class LoginEvent {

	public static class Login extends Event {

		public Login(Object source) {
			super(source);
		}
	}

	public static class Logout extends Event {

		public Logout(Object source) {
			super(source);
		}
	}
}
