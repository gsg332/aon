package com.aon.lib.nosql;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Component;

/**
 * mongo db에 문제가 생겨도 서비스는 문제 없도록 
 * exception을 발생시키지 않는다.
 * @author kskim
 *
 */

public class MongoTemplateWrapper {

	 
	 private MongoTemplate mongoTemplate;
	 
	 public void insert(Object object){
		 try{
			 mongoTemplate.insert(object);
		 }catch(Exception e){
			 e.printStackTrace();
		 }
	 }
	 
	 public void remove(Object object){
		 try{
			 mongoTemplate.remove(object);
		 }catch(Exception e){
			 e.printStackTrace();
		 }
	 }
	 
	 public <T> List<T> find(Query query, Class<T> entityClass) {
		 try{
			return mongoTemplate.find(query, entityClass);
		 }catch(Exception e){
			 e.printStackTrace();
		 }
		 return null;
	 }
	 
	 
}
