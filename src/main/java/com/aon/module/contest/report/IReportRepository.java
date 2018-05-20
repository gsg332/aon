package com.aon.module.contest.report;

import org.springframework.stereotype.Repository;

import com.aon.doc.IBaseRepository;

@Repository
public interface IReportRepository extends IBaseRepository<Report, Long> {
	
}
