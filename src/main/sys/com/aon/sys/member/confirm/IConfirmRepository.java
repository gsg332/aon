package com.aon.sys.member.confirm;

import org.springframework.stereotype.Repository;

import com.aon.doc.IBaseRepository;

@Repository
public  interface IConfirmRepository extends IBaseRepository<Confirm, Long>{
	public Confirm findByLoginId(String loginId);
	public void deleteByLoginId(String loginId);
	public Confirm findByConfirmCode(String confirmCode);
}

