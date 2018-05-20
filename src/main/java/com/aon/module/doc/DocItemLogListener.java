package com.aon.module.doc;

import org.springframework.stereotype.Component;

import com.aon.module.doc.DocItemEvent.Create;
import com.aon.module.doc.DocItemEvent.Delete;

@Component
public class DocItemLogListener implements IDocItemListener{

	@Override
	public void create(Create e) throws Exception{
		System.out.println("create log");
	}		

	@Override
	public void delete(Delete e) throws Exception{
		System.out.println("delete log");
	}		
}
