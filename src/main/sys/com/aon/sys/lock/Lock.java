package com.aon.sys.lock;

import java.io.Serializable;


public class Lock implements Serializable
{
	private static final long serialVersionUID = -1426886663366978743L;

	private String _name;

	public String getName()
	{
		return _name;
	}
	
	public void setName(String name)
	{
		_name = name;
	}

}
