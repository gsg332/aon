package com.aon.sys.certify.sms;

import com.aon.sys.conf.ConfigKey;
import com.aon.sys.conf.ConfigUI;
import com.aon.sys.conf.ConfigUI.UI;

public interface SmsCertifyConfig {
	
	@ConfigKey("awsAccessKey")
	@ConfigUI(type=UI.INPUT)
	String getAwsAccessKey();
	
	@ConfigKey("awsSecretKey")
	@ConfigUI(type=UI.INPUT)
	String getAwsSecretKey();

}
