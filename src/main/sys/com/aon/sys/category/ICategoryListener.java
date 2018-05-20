package com.aon.sys.category;

import org.springframework.context.event.EventListener;

/**
 * Category의 변경사항을 통보한다.
 */
public interface ICategoryListener
{
	@EventListener
	public void move(CategoryEvent.Move e) throws Exception;
	
	@EventListener
	public void delete(CategoryEvent.Delete e) throws Exception;
}
