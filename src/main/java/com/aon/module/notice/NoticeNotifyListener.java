package com.aon.module.notice;

import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import com.aon.module.notice.NoticeEvent.Create;
import com.aon.module.notice.NoticeEvent.Delete;

@Component
public class NoticeNotifyListener implements INoticeListener{

	@EventListener
	public void create(Create e) {

	}

	@EventListener
	public void delete(Delete e) {
		
	}

}
