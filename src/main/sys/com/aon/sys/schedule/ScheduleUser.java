package com.aon.sys.schedule;

import com.aon.sys.usr.User;
import com.aon.sys.usr.UserSession;



public class ScheduleUser extends UserSession
{

	private static final long serialVersionUID = -6222315829671614520L;

	public ScheduleUser()
	{
		setUser(new User(new Long(0), "scheduler[system]"));
		setAdmin(true);
	}

}
