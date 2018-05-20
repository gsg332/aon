package com.aon.module.notice;

import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import com.aon.module.notice.NoticeEvent.Create;
import com.aon.module.notice.NoticeEvent.Delete;

@Component
public class NoticeLogListener implements INoticeListener{


	@Override
	@EventListener
	public void create(Create e) {
		System.out.println("create log");
	}		

	@Override
	@EventListener
	public void delete(Delete e) {
		System.out.println("delete log");
	}		
}
