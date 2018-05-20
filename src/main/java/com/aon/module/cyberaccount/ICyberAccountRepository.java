package com.aon.module.cyberaccount;

import org.springframework.stereotype.Repository;

import com.aon.doc.IBaseRepository;

@Repository
public interface ICyberAccountRepository extends IBaseRepository<CyberAccount, Long> {
	
	/**
	 * 회원일련번호로 가상계좌를 얻는다.
	 *
	 * @param id
	 * @return
	 */
	public CyberAccount findByMemberId(Long memberId);
	
}
