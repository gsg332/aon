package com.aon.doc;

import java.io.Serializable;

import javax.persistence.LockModeType;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.repository.NoRepositoryBean;


@NoRepositoryBean
public interface IBaseRepository<T,ID extends Serializable> extends  JpaRepository<T, ID> {

	default public T create(T object){
		return save(object);
	}
	
	/**
	 * 수정을 위한 경우만 lock 처리한다. 
	 * @param id
	 * @return
	 */
	@Lock(value = LockModeType.PESSIMISTIC_READ)
	default public T loadWithLock(ID id){
		return findOne(id);
	}
}
