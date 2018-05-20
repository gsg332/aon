package com.aon.sys.schedule;

import javax.annotation.PreDestroy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class ScheduleStart {

	@Autowired
	private ScheduleTask schedule;

	@Scheduled(fixedDelay = 60000)
	public void start() throws Exception {
		schedule.run();
	}

	@PreDestroy
	public void stop() {
		schedule.stop();
	}
}
