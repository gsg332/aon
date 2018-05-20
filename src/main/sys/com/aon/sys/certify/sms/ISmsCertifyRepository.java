package com.aon.sys.certify.sms;

import org.springframework.stereotype.Repository;

import com.aon.doc.IBaseRepository;

@Repository
public interface ISmsCertifyRepository extends IBaseRepository<SmsCertify, Long> {

	/**
	 * 회원일련번호, 인증번호를 받아서 인증대기(resultCode = 0)중인 가장 최신의 row를 얻는다.  
	 *
	 * @param memberId
	 * @param result
	 * @param certifyNumber
	 * @return
	 */
	public SmsCertify findFirstByMemberIdAndResultCodeAndCertifyNumberOrderByIdDesc(Long memberId, int resultCode, String certifyNumber);
	
	/**
	 * 인증일련번호, 회원번호, 인증결과가 성공인 인증결과를 돌려준다.
	 *
	 * @param id
	 * @param memberId
	 * @param resultCode
	 * @return
	 */
	public SmsCertify findOneByIdAndMemberIdAndResultCode(Long id, Long memberId, int resultCode);

}
