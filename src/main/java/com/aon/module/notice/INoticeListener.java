package com.aon.module.notice;

public interface  INoticeListener {

	public void create(NoticeEvent.Create e);
	
	public void delete(NoticeEvent.Delete e);
	
}
