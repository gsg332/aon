package com.aon.module.doc;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import com.aon.doc.BaseController;
import com.aon.doc.BaseJsonView;
import com.aon.doc.Permission;
import com.aon.doc.hist.ReadService;
import com.aon.doc.reply.ReplyService;
import com.aon.sys.conf.ConfigService;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.QueryResults;

@Controller
@RequestMapping("/module/doc")
public class DocItemUserController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(DocItemUserController.class);

	@Autowired
	private DocItemService service;

	@Autowired
	private IDocItemRepository repository;

	@Autowired
	private DocItemQuery query;
	
	private DocItemMongoService mservice;

	@Autowired
	private DocItemVaildator validator;

	private ReadService read;
	private ReplyService reply;
	private Permission permission;
	private DocItemConfig config;
	private DocItemMessageConfig message;

	@Override
	public void init() {
		read = new ReadService(DocItem.class);
		reply = new ReplyService(DocItem.class);
		permission = new Permission();
		config = (DocItemConfig) ConfigService.getConfig(DocItemConfig.class);
		message =  (DocItemMessageConfig) ConfigService.getConfig(DocItemMessageConfig.class);
	}

	@RequestMapping(value = "/list")
	@JsonView(BaseJsonView.Summary.class)
	public Model list(Pageable page, Model model) throws Exception {
		// Page<DocItem> result = service.list(page);
		// logger.debug("result count=" + result.getTotalElements());
		// logger.debug("result page count=" + result.getTotalPages());
		// return model.addAttribute("list", result.getContent())
		// .addAttribute("count", result.getTotalElements());

		//System.out.println(config.getSampleInt()+" "+config.getSampleString()+" "+config.getSampleLong());
		QueryResults<DocItem> result = query.getList(page);
		return model.addAttribute("list", result.getResults()).addAttribute("count", result.getTotal());
	}
	
	@RequestMapping(value = "/timeline")
	@JsonView(BaseJsonView.Summary.class)
	public Model timeline(Pageable page, Model model) throws Exception {
		//Query query = new Query(Criteria.where("title").is("ddd")); //제목이 ddd 인 글 
		Query query = new Query(Criteria.where("registerUser.memberId").in(new Long(42)));
		query.with(new Sort(Sort.Direction.DESC,"id"));
	
		List<DocItem> result = mservice.find(query);
		return model.addAttribute("list", result);
	}
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	@ResponseStatus(code = HttpStatus.OK)
	public void register(DocItem client, BindingResult result) throws Exception {

		validator.validate(client, result);
		checkBindingResult(result);
		DocItem server = service.loadOrCreate(client.getId());
		service.update(server, client);
		service.register(server);

		reply.setStepPos(server);
		reply.increaseParentRplyCnt(server);
		reply.checkParentExists(server);

	}

	/**
	 * 조회용
	 * 
	 * @param id
	 * @param m
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/read")
	@JsonView(BaseJsonView.Detail.class)
	public Model read(Long id, Model m) throws Exception {
		DocItem server = repository.findOne(id);
		// 조회가능 상태인지 확인
		// permission.read(server);
		// TODO:차후처리
		read.read(null, server);
		m.addAttribute("item", server);
		logger.debug("toString  =" + server.toString());
		return m;
	}

	/**
	 * 수정을 위한 조회
	 * 
	 * @param client
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/readForUpdate")
	@JsonView(BaseJsonView.Detail.class)
	public Model readForUpdate(Long id, Model m) throws Exception {

		DocItem server = repository.findOne(id);
		// 수정권한이 있는지
		permission.checkOwner(server);
		m.addAttribute("item", server);
		return m;
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseStatus(code = HttpStatus.OK)
	public void update(DocItem client, BindingResult result) throws Exception {

		validator.validate(client, result);
		checkBindingResult(result);
		DocItem server = repository.loadWithLock(client.getId());// require lock
		permission.checkOwner(server);
		// 버전비교 및 update
		service.update(server, client);
	}
	
	@RequestMapping(value = "/delete")
	@ResponseStatus(code = HttpStatus.OK)
	public void delete(Long id) throws Exception {

		DocItem server = repository.findOne(id);
		// 권한  있는지
		permission.checkOwner(server);
		service.remove(server);
	}
	
	@RequestMapping(value="/{path}/test")
	public ModelAndView test(@PathVariable("path")  String path){
		System.out.println(path);
		ModelAndView model = new ModelAndView();
		model.setViewName("/module/doc/uitest");
		return model;
	}

	@RequestMapping(value="/download")
	@ResponseBody
	public void download(HttpServletRequest request, HttpServletResponse response,Long id) throws Exception{
		DocItem.Attachment att = 
				(DocItem.Attachment) query.find(DocItem.Attachment.class,id);
			DocItem server = (DocItem) att.getEntity();
			//TODO : permission check
			super.download(request, response, att, false);
	}
}
