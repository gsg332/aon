package com.aon.module.bankaccount;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aon.sys.usr.UserService;

@Service
public class BankAccountService {

	@Autowired
	IBankAccountRepository repository;

	/**
	 * bankAccount 테이블 생성을 위해 검색
	 * 
	 * @param id
	 * @return
	 */
	public BankAccount loadOrCreate() throws Exception {
		BankAccount bankAccount = repository.findByMemberId(UserService.getMemberId());
		if (bankAccount == null) {
			return repository.create(new BankAccount());
		}
		return bankAccount;
	}

	/**
	 * bankAccount 테이블 생성을 위해 검색
	 * 
	 * @param id
	 * @return
	 */
	public BankAccount loadOrCreate(Long id) throws Exception {
		BankAccount bankAccount = repository.findByMemberId(id);
		if (bankAccount == null) {
			return repository.create(new BankAccount());
		}
		return bankAccount;
	}
}
