package com.aon.sys.conf;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.aon.lib.http.StartEvent;
import com.aon.lib.http.StartupListener;
 

@Service
public class ConfigStartupListener implements StartupListener{

	private static final Logger logger = LoggerFactory.getLogger(ConfigStartupListener.class);

	@Override
	public void start(StartEvent e) throws Exception {
		ConfigCache.init();
		ConfigService.init();
		logger.debug("ConfigStartupListener started");
	}

}
