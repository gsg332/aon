package com.aon.module.notice;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.aon.doc.BaseController;
import com.aon.doc.BaseJsonView;
import com.aon.doc.Permission;
import com.aon.module.notice.Notice;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.QueryResults;

@Controller
@RequestMapping("/supervisor/module/notice")
public class NoticeAdminController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(NoticeAdminController.class);

	@Autowired
	private NoticeService service;

	@Autowired
	private INoticeRepository repository;

	@Autowired
	private NoticeQuery query;
	
	@Autowired
	private NoticeVaildator validator;
	
	private  Permission permission;
	
	@Override
	public void init() {
		permission = new Permission();
	}
	
	/**
	 * 목록 조회
	 * @param page
	 * @param searchKey
	 * @param searchValue
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/listPage")
	@JsonView(BaseJsonView.Summary.class)
	public Model list(Pageable page, String searchKey, String searchValue, Model model) throws Exception {
		QueryResults<Notice> result = query.list(page, searchKey, searchValue);

		model.addAttribute("list", result.getResults());
		model.addAttribute("count", result.getTotal());
		return model;
	}
	
	/**
	 * 등록
	 * @param client
	 * @param result
	 * @throws Exception
	 */
	@RequestMapping(value = "/register",method = RequestMethod.POST)
	@ResponseStatus(code=HttpStatus.OK)
	public void register(Notice client, BindingResult result) throws Exception {
		validator.validate(client, result);
		checkBindingResult(result);

		Notice server = service.loadOrCreate(client.getId());
		
		service.update(server, client);
		service.register(server);
	}
	
	/**
	 * 조회
	 * @param id
	 * @param searchKey
	 * @param searchValue
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/read")
	@JsonView(BaseJsonView.Detail.class)
	public Model read(Long id, String searchKey, String searchValue, Model model) throws Exception
	{
		Notice server = repository.findOne(id);
		
		model.addAttribute("item", server);
		return model;
	}

	/**
	 * 수정을 위한 조회
	 * @param id
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/readForUpdate")
	@JsonView(BaseJsonView.Detail.class)
	public Model readForUpdate(Long id, Model model) throws Exception
	{
		Notice server = repository.findOne(id);
		// 수정권한이 있는지
		permission.checkAdmin();
		model.addAttribute("item", server);
		return model;
	}
	
	/**
	 * 수정
	 * @param client
	 * @param result
	 * @throws Exception
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseStatus(code=HttpStatus.OK)
	public void update(Notice client, BindingResult result) throws Exception {
		validator.validate(client, result);
		checkBindingResult(result);
		Notice server = repository.findOne(client.getId());// require lock
		permission.checkAdmin();
		service.update(server, client);
	}
	
	/**
	 * 삭제
	 * @param client
	 * @param result
	 * @throws Exception
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseStatus(code=HttpStatus.OK)
	public void delete(Notice client, BindingResult result) throws Exception {
		Notice server = repository.findOne(client.getId());
		permission.checkAdmin();
		repository.delete(server.getId());
	}
	
}
