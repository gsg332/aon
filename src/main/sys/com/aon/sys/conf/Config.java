package com.aon.sys.conf;

import java.io.Serializable;

import com.aon.doc.BaseJsonView;
import com.fasterxml.jackson.annotation.JsonView;


public class Config implements Serializable
{
	private static final long serialVersionUID = -5038408578334324990L;

	@JsonView(BaseJsonView.Summary.class)
	private String key;
	
	@JsonView(BaseJsonView.Summary.class)
	private String value;

	public String getKey()
	{
		return key;
	}

	public void setKey(String key)
	{
		this.key = key;
	}

	public String getValue()
	{
		return value;
	}

	public void setValue(String value)
	{
		this.value = value;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	public boolean equals(Object obj)
	{
		if (key == null || !(this.getClass().isInstance(obj)))
		{
			return false;
		}
		return key.equals(((Config) obj).getKey());
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode()
	{
		if (key == null)
		{
			return super.hashCode();
		}
		return key.hashCode();
	}

}
