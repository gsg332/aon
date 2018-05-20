package com.aon.module.onlineask;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.aon.doc.BaseController;
import com.aon.doc.BaseJsonView;
import com.aon.sys.usr.User;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.QueryResults;

@Controller
@RequestMapping("/supervisor/module/onlineAsk") // Mapping.ADMIN_PATH
@Secured(User.ROLE_ADMIN) // User.ROLE_TYPE_ADMIN
public class OnlineAskAdminController extends BaseController {
	static final Logger LOGGER = LoggerFactory.getLogger(OnlineAskAdminController.class);
	@Autowired
	private OnlineAskService service;
	@Autowired
	private IOnlineAskRepository repository;
	@Autowired
	private OnlineAskQuery query;

	@RequestMapping("/listPage")
	@JsonView(BaseJsonView.Detail.class)
	public Model list(Pageable page, Model model) throws Exception {
		
		QueryResults<OnlineAsk> result = query.getList(page);
		
		//LOGGER.debug(result.getResults().toString());
		
		return model.addAttribute("list", result.getResults()).addAttribute("count", result.getTotal());
	}

	@RequestMapping("/complete")
	@ResponseStatus(code = HttpStatus.OK)
	public void complete(OnlineAsk client, BindingResult result) throws Exception {
		LOGGER.debug("##############complete#############");
		LOGGER.debug(client.getId().toString());
		OnlineAsk server = repository.loadWithLock(client.getId());
		service.complete(server, client);
	}

	@RequestMapping("/read")
	@JsonView(BaseJsonView.Detail.class)
	public Model read(Long id, Model model) throws Exception {
		OnlineAsk item = repository.findOne(id);
		LOGGER.debug(item.getStatus()+"");
		model.addAttribute("item", item);
		return model;
	}
}
