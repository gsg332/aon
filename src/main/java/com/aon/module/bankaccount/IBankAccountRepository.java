package com.aon.module.bankaccount;

import org.springframework.stereotype.Repository;

import com.aon.doc.IBaseRepository;

@Repository
public interface IBankAccountRepository extends IBaseRepository<BankAccount, Long> {
	public BankAccount findByMemberId(Long id);
}
