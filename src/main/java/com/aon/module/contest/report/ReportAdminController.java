package com.aon.module.contest.report;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.aon.doc.BaseJsonView;
import com.aon.module.contest.Contest;
import com.aon.sys.usr.User;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.QueryResults;

@Controller
@RequestMapping("/supervisor/module/contest/report")
@Secured(User.ROLE_ADMIN)
public class ReportAdminController {

	static final Logger LOGGER = LoggerFactory.getLogger(ReportAdminController.class);

	@Autowired
	private ReportAdminQuery query;

	@Autowired
	private ReportService service;

	@RequestMapping("/listPage")
	@JsonView(BaseJsonView.Summary.class)
	public Model list(ReportSearch search, Pageable page, Model model) throws Exception {
		QueryResults<Report> result = query.getList(search, page);
		return model.addAttribute("list", result.getResults()).addAttribute("count", result.getTotal());
	}

	@RequestMapping("/readSingle")
	@JsonView(BaseJsonView.Summary.class)
	public Model readSingle(Long id, Model model) throws Exception {
		Report server = service.findOne(id);
		return model.addAttribute("item", server);
	}

	@RequestMapping(value="/singleConfirm", method = RequestMethod.POST)
	@ResponseStatus(code = HttpStatus.OK)
	public void singleConfirm(Report client) throws Exception {
		Report server = service.findOne(client.getId());
		service.confirm(server, client);
	}

	@RequestMapping("/readAll")
	public Model readAll(Long qaId, Model model) throws Exception {
		LOGGER.debug("qaId : " + qaId + "");
		Contest contest = service.findContest(qaId);
		model.addAttribute("contest", contest);
		
		List<Report> result = query.getListByQaId(qaId);
		model.addAttribute("reportList", result);

		return model;
	}
}
