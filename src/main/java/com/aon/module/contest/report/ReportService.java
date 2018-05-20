package com.aon.module.contest.report;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aon.module.contest.Contest;
import com.aon.module.contest.IContestRepository;
import com.aon.sys.usr.UserService;

@Service
public class ReportService {
	@Autowired
	private IReportRepository repository;
	
	@Autowired
	private IContestRepository contestRepository;

	public Report create() {
		return repository.create(new Report());
	}

	public Report loadOrCreate(Long id) {
		if (id == null) {
			return repository.create(new Report());
		}
		return repository.loadWithLock(id);
	}

	public Report findOne(Long id) {
		return repository.findOne(id);
	}
	
	public Contest findContest(Long id){
		return contestRepository.findOne(id);
	}

	public void register(Report server, Report client) throws Exception {
		server.setQaId(client.getQaId());
		server.setContent(client.getContent());
		server.setConfirm(false);
		server.setReportUser(UserService.getUser());
		server.setInsertDate(new Date());
	}
	
	public void confirm(Report server, Report client) throws Exception{
		server.setConfirmDate(new Date());
		server.setConfirm(true);
		server.setAdminUser(UserService.getUser());
		server.setAdminComment(client.getAdminComment());
	}
}
