package com.aon.sys.schedule;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aon.module.doc.DocItem;
import com.aon.module.doc.IDocItemRepository;

@Service
public class TestSchedule implements ISchedule {

	@Autowired
	private IDocItemRepository repository;

	@Override
	public void execute(Map<String, String> p) throws Exception {
		DocItem item = repository.findById(new Long(p.get("id")));
		System.out.println("#####################TEST SCHEDULE EXECUTE #####################");
		System.out.println("#####################id" + p.get("id") + " #####################");
		System.out.println("#####################item.title" + item.getTitle() + " #####################");
	}

}
