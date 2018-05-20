package com.aon.module.notice;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aon.lib.event.EventPublisher;
import com.aon.module.notice.Notice;
import com.aon.module.notice.NoticeEvent;
import com.aon.sys.usr.UserService;

@Service
public class NoticeService {

	@Autowired
	private INoticeRepository repository;
	
	@Autowired
	private EventPublisher publisher;
	
	/**
	 * 공지사항 객체를 생성한다.
	 * 
	 * @param id
	 * @return
	 */
	public Notice loadOrCreate(Long id){
		Notice server = new Notice();
		if (id == null) {
			return repository.create(server);
		}
		return repository.loadWithLock(id);
	}
	
	/**
	 * 공지사항 등록
	 * 
	 * @param server
	 * @throws Exception
	 */
	public void register(Notice server) throws Exception {
		
		//TODO:등록상태 및 시간 처리
		server.setRegisterUser(UserService.getUser());
		server.setInsertDate(new Date());
		server.updateVisible(true);
		publisher.broadcast(new NoticeEvent.Create(server));
	}
	
	/**
	 * 공지사항 수정
	 * 
	 * @param server
	 * @param client
	 * @throws Exception
	 */
	public void update(Notice server, Notice client) throws Exception {
		 server.setTitle(client.getTitle());
		 server.setContent(client.getContent());
		 server.setUpdateDate(new Date());
		 server.updateVisible(server.isVisible());
	}

}