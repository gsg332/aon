package com.aon.module.doc;

import com.aon.sys.conf.ConfigKey;
import com.aon.sys.conf.ConfigUI;
import com.aon.sys.conf.ConfigUI.UI;

public interface DocItemMessageConfig {

	public static final String REGISTER = "com.aon.module.doc.DocItemMessageConfig.sampleMessage";

	@ConfigKey("sampleMessage")
	@ConfigUI(type=UI.TEXTAREA)
	String getSampleMessage();
	
	
	@ConfigKey("sampleMessage2")
	@ConfigUI(type=UI.TEXTAREA)
	String getSampleMessage2();
}
