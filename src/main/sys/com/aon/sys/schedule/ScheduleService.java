package com.aon.sys.schedule;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aon.sys.schedule.Schedule;

@Service
public class ScheduleService {

	@Autowired
	private IScheduleRepository repository;
	
	/**
	 * 스케줄 객체를 생성한다.
	 * 
	 * @param id
	 * @return
	 */
	public Schedule loadOrCreate(Long id){
		Schedule server = new Schedule();
		if (id == null) {
			return repository.create(server);
		}
		return repository.loadWithLock(id);
	}
	
	/**
	 * 스케줄 등록
	 * 
	 * @param server
	 * @throws Exception
	 */
	public void register(Schedule server) throws Exception {
		
		//TODO:등록상태 및 시간 처리
		server.setInsertDate(new Date());
	}
	
	/**
	 * 스케줄 수정
	 * 
	 * @param server
	 * @param client
	 * @throws Exception
	 */
	public void update(Schedule server, Schedule client) throws Exception {
		server.setClassName(client.getClassName());
		server.setParam(client.getParam());
		server.setCron(client.getCron());
		server.setInterval(client.getInterval());
		server.calcRunTime();

	}
	
	/**
	 * 스케줄 정지/시작
	 * 
	 * @param server
	 * @param client
	 * @throws Exception
	 */
	public void toggle(Schedule server, Schedule client) throws Exception {
		server.setPaused(client.isPaused());
	}

}