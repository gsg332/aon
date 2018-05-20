package com.aon.module.notice;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aon.doc.BaseController;
import com.aon.doc.BaseJsonView;
import com.aon.doc.hist.ReadService;
import com.aon.module.notice.Notice;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.QueryResults;

@Controller
@RequestMapping("/module/notice")
public class NoticeUserController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(NoticeUserController.class);

	@Autowired
	private INoticeRepository repository;

	@Autowired
	private NoticeQuery query;
	
	
	private  ReadService read;
	
	@Override
	public void init() {
		read = new ReadService(Notice.class);
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

		Notice previous = query.getPrevious(id, searchKey, searchValue, server.getInsertDate());
		Notice next = query.getNext(id, searchKey, searchValue, server.getInsertDate());
		read.read(null, server);
		model.addAttribute("item", server);
		
		model.addAttribute("previous", previous);
		model.addAttribute("next", next);
		return model;
	}

}
