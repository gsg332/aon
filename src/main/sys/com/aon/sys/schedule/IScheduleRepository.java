package com.aon.sys.schedule;

import org.springframework.stereotype.Repository;

import com.aon.doc.IBaseRepository;

@Repository
public interface IScheduleRepository extends IBaseRepository<Schedule, Long>{
	
}