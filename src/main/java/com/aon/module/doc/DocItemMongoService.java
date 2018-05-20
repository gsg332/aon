package com.aon.module.doc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

import com.aon.lib.nosql.MongoTemplateWrapper;


public class DocItemMongoService {

	 private MongoTemplateWrapper mongoTemplate;
	 
	 
	 public void insert(DocItem item){
		 mongoTemplate.insert(item);
	 }
	 
	 public void delete(DocItem item){
		 mongoTemplate.remove(item);
	 }
	

	public List<DocItem> find(Query query) {
		return mongoTemplate.find(query, DocItem.class);
	}
}
