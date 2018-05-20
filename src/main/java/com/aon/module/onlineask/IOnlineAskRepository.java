package com.aon.module.onlineask;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import com.aon.doc.IBaseRepository;

@Repository
public interface IOnlineAskRepository extends IBaseRepository<OnlineAsk, Long> {

	public Page<OnlineAsk> findByTitleStartingWith(String title, Pageable pageable);

	public Page<OnlineAsk> findAllByOrderByInsertDateDesc(Pageable pageable);

}
