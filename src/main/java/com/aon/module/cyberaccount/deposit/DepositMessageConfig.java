package com.aon.module.cyberaccount.deposit;

import com.aon.sys.conf.ConfigKey;
import com.aon.sys.conf.ConfigUI;
import com.aon.sys.conf.ConfigUI.UI;

public interface DepositMessageConfig {

	public static final String CONFIRM = "com.aon.module.cyberaccount.deposit.DepositMessageConfig.confirmMessage";

	@ConfigKey("confirmMessage")
	@ConfigUI(type = UI.TEXTAREA)
	String getConfirmMessage();
}
