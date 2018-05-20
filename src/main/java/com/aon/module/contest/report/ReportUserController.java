package com.aon.module.contest.report;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aon.doc.BaseController;

@Controller
@RequestMapping("/module/contest/report")
public class ReportUserController extends BaseController {
	static final Logger LOGGER = LoggerFactory.getLogger(Report.class);
	@Autowired
	private ReportService service;

	@RequestMapping(value = "/sendReport", method = RequestMethod.POST)
	public void report(Report client) throws Exception {
		LOGGER.debug(client.getQaId() + "");
		LOGGER.debug(client.getContent() + "");
		Report server = service.loadOrCreate(client.getId());
		service.register(server, client);
	}
}
