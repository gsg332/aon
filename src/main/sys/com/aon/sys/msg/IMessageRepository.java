package com.aon.sys.msg;

import org.springframework.stereotype.Repository;

import com.aon.doc.IBaseRepository;

@Repository
public interface IMessageRepository extends IBaseRepository<Message, Long> {

}
