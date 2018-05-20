package com.aon.lib.app;

import com.aon.sys.conf.ConfigKey;
import com.aon.sys.conf.ConfigUI;
import com.aon.sys.conf.ConfigUI.UI;

public interface AppConfig {

	@ConfigKey("useAnalytics")
	@ConfigUI(type=UI.CHECKBOX)
	boolean useAnalytics();
}
