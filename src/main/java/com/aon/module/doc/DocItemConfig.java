package com.aon.module.doc;

import com.aon.sys.conf.ConfigKey;
import com.aon.sys.conf.ConfigUI;
import com.aon.sys.conf.ConfigUI.UI;

public interface DocItemConfig {

	@ConfigKey("sampleInt")
	@ConfigUI(type=UI.INPUT)
	int getSampleInt();
	
	@ConfigKey("sampleString")
	@ConfigUI(type=UI.TEXTAREA)
	String getSampleString();
	
	@ConfigKey("sampleLong")
	@ConfigUI(type=UI.INPUT)
	Long getSampleLong();
	
	@ConfigKey("sampleChekbox")
	@ConfigUI(type=UI.CHECKBOX)
	boolean getSampleChekbox();
	
}
