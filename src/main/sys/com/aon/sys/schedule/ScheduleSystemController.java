package com.aon.sys.schedule;

import java.util.Date;

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
import com.aon.sys.schedule.Schedule;
import com.aon.sys.schedule.log.SysLog;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.QueryResults;

@Controller
@RequestMapping("/system/schedule")
public class ScheduleSystemController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(ScheduleSystemController.class);

	@Autowired
	private ScheduleService service;
	
	@Autowired
	private IScheduleRepository repository;
	
	@Autowired
	private ScheduleQuery query;
	
	@Autowired
	private ScheduleVaildator validator;
	
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
	public Model list(Pageable page, String searchValue, Model model) throws Exception {
		QueryResults<Schedule> result = query.list(page, searchValue);

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
	public void register(Schedule client, BindingResult result) throws Exception {
		validator.validate(client, result);
		checkBindingResult(result);

		Schedule server = service.loadOrCreate(client.getId());
		
		service.update(server, client);
		service.register(server);
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
		Schedule server = repository.findOne(id);
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
	public void update(Schedule client, BindingResult result) throws Exception {
		validator.validate(client, result);
		checkBindingResult(result);
		Schedule server = repository.findOne(client.getId());// require lock
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
	public void delete(Schedule client, BindingResult result) throws Exception {
		Schedule server = repository.findOne(client.getId());
		permission.checkAdmin();
		repository.delete(server.getId());
	}
	
	/**
	 * 로고 목록 조회
	 * 
	 * @param page
	 * @param searchValue
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/logPage")
	@JsonView(BaseJsonView.Summary.class)
	public Model log(Pageable page, String searchValue, Date startDate, Date endDate, Model model) throws Exception {
		QueryResults<SysLog> result = query.log(page, searchValue, startDate, endDate);

		model.addAttribute("list", result.getResults());
		model.addAttribute("count", result.getTotal());
		return model;
	}
	
	/**
	 * 스케줄 정지/시작
	 * 
	 * @param client
	 * @param result
	 * @throws Exception
	 */
	@RequestMapping(value = "/toggle", method = RequestMethod.GET)
	@ResponseStatus(code=HttpStatus.OK)
	public void toggle(Schedule client, BindingResult result) throws Exception {
		Schedule server = repository.findOne(client.getId());// require lock
		permission.checkAdmin();
		service.toggle(server, client);
	}
	
}
