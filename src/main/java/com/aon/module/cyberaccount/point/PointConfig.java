package com.aon.module.cyberaccount.point;

import com.aon.sys.conf.ConfigKey;
import com.aon.sys.conf.ConfigUI;
import com.aon.sys.conf.ConfigUI.UI;

public interface PointConfig {
	
	@ConfigKey("ratioDollarToPoint")
	@ConfigUI(type=UI.INPUT)
	int getRatioDollarToPoint();

	@ConfigKey("feesPercent")
	@ConfigUI(type=UI.INPUT)
	int getFeesPercent();
}
