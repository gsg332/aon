package com.aon.module.notice;

import org.springframework.stereotype.Repository;

import com.aon.doc.IBaseRepository;

@Repository
public interface INoticeRepository extends IBaseRepository<Notice, Long>{
	
}