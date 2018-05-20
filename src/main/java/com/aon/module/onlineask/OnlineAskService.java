package com.aon.module.onlineask;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.aon.sys.usr.UserService;

@Service
public class OnlineAskService {
	private static final Logger LOGGER = LoggerFactory.getLogger(OnlineAskService.class);
	@Autowired
	private IOnlineAskRepository repository;

	public Page<OnlineAsk> list(Pageable page) {

		return repository.findAllByOrderByInsertDateDesc(page);
	}

	public OnlineAsk loadOrCreate(Long id) {
		if (id == null) {
			return repository.create(new OnlineAsk());
		}
		return repository.loadWithLock(id);
	}

	public void update(OnlineAsk server, OnlineAsk client) {
		server.setUserName(client.getUserName());
		server.setLoginid(client.getLoginid());
		server.setContent(client.getContent());
		server.setEmail(client.getEmail());
	}

	public void regist(OnlineAsk server) {
		server.setInsertDate(new Date());
		server.setStatus(OnlineAsk.STATUS_WAIT);
	}

	public void complete(OnlineAsk server, OnlineAsk client) throws Exception{
		LOGGER.debug("complete onlineask");
		LOGGER.debug(UserService.getUser().getMemberId()+"");
		server.setAdminComment(client.getAdminComment());
		server.setStatus(OnlineAsk.STATUS_COMPLETE);
		server.setUpdateDate(new Date());		
		server.setAdminId(UserService.getUser().getMemberId());
	}
}
