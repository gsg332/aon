package com.aon.module.contest;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aon.lib.event.EventPublisher;
import com.aon.sys.schedule.ISchedule;

@Service
public class ContestExpiredSchedule implements ISchedule {
	
	@Autowired
	ContestQuery query;
	
	@Autowired
	IContestRepository repository;
	
	@Autowired
	private EventPublisher publisher;
	
	@Override
	public void execute(Map<String, String> p) throws Exception {
		List<Contest> contestList = query.getExpectExpire();
		
		for (Contest contest : contestList) {
			contest.setStatus(Contest.EXPIRED_STATUS);
			repository.save(contest);
			
			publisher.broadcast(new ContestEvent.Expire(contest));
		}
	}
}
