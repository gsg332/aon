package com.aon.sys.msg;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.aon.doc.BaseController;
import com.aon.doc.BaseJsonView;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.QueryResults;


@Controller
@RequestMapping("/sys/message")
public class MessageController extends BaseController{

	@Autowired 
	private MessageService service;
	
	/**
	 * 신규메시지 목록을 가져온다. 기본 사이즈는 5개, 더보기할경우 5개씩 ..
	 * @param page
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/list")
	@JsonView(BaseJsonView.Summary.class)
	public Model getMessages(Long id, Model model) throws Exception{
		//최신목록으로 가져오기
		List<Message> result = service.getList(id);
		model.addAttribute("count", result.size());
		model.addAttribute("list", result);
		return model;
	}
	
	/**
	 * 메시지 읽음 처리
	 * 
	 * @param ids
	 * @throws Exception
	 */
	@RequestMapping("/readCheck")
	@JsonView(BaseJsonView.Summary.class)
	public void setReadCheck(String ids) throws Exception{
		service.setReadCheck(ids);
	}	
	
	@RequestMapping("/newMsgCount")
	public Model getNewMsgCount(Model model) throws Exception{
		model.addAttribute("count", service.getNewMsgCount());
		return model;
	}
	
	/**
	 * 삭제 
	 * @param model
	 * @throws Exception 
	 */
	@RequestMapping("/delete")
	@ResponseStatus(code = HttpStatus.OK)
	public void deleteMessages(Long messageId) throws Exception{
		service.deleteByReceiver(messageId);
	}
	
	@RequestMapping("/deleteAll")
	@ResponseStatus(code = HttpStatus.OK)
	public void deleteAllMessage()  throws Exception{
		service.deleteAllByReceiver();
	}
}
