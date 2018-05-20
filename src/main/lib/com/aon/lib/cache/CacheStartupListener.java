package com.aon.lib.cache;

import org.springframework.stereotype.Service;

import com.aon.lib.http.StartEvent;
import com.aon.lib.http.StartupListener;


@Service
public class CacheStartupListener implements StartupListener{

	@Override
	public void start(StartEvent e) throws Exception {
		CacheService.init();
	}

}
