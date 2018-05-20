package com.aon.module.doc;


import com.aon.module.doc.DocItemEvent.Create;
import com.aon.module.doc.DocItemEvent.Delete;

public class DocItemMongoListener implements IDocItemListener{

	private DocItemMongoService service;
	
	@Override
	public void create(Create e) throws Exception{
		service.insert((DocItem) e.getSource());
	}

	@Override
	public void delete(Delete e) throws Exception{
		service.delete((DocItem)e.getSource());
		
	}

}
