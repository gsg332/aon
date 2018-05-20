package com.aon.module.cyberaccount.withdraw;

import com.aon.sys.conf.ConfigKey;
import com.aon.sys.conf.ConfigUI;
import com.aon.sys.conf.ConfigUI.UI;

public interface WithdrawMessageConfig {
	
	public static final String CONFIRM = "com.aon.module.cyberaccount.withdraw.WithdrawMessageConfig.confirmMessage";
	
	@ConfigKey("confirmMessage")
	@ConfigUI(type = UI.TEXTAREA)
	String getConfirmMessage();
}
