package com.aon.module.cyberaccount.withdraw;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.aon.lib.event.EventPublisher;
import com.aon.module.cyberaccount.CyberAccountService;
import com.aon.module.cyberaccount.point.Point;
import com.aon.module.cyberaccount.point.PointConfig;
import com.aon.sys.certify.sms.SmsCertifyService;
import com.aon.sys.conf.ConfigService;
import com.aon.sys.usr.UserService;
import com.querydsl.core.QueryResults;
import com.querydsl.core.Tuple;

@Service
public class WithdrawService {

	private static final Logger logger = LoggerFactory.getLogger(WithdrawService.class);

	@Autowired
	private IWithdrawRepository repository;

	@Autowired
	private CyberAccountService cyberAccountService;

	@Autowired
	private SmsCertifyService smsCertifyService;

	@Autowired
	private WithdrawAdminQuery adminQuery;

	@Autowired
	private EventPublisher publisher;

	private PointConfig pointConfig = (PointConfig) ConfigService.getConfig(PointConfig.class);

	/**
	 * 출금신청을 등록처리한다.
	 *
	 * @param client
	 * @throws Exception
	 */
	public void register(Withdraw client) throws Exception {
		// 잔액 체크.
		cyberAccountService.checkBalance(client.getRequestPoint());

		client.setStatus(Withdraw.APPLIED_STATUS);
		client.setInsertDate(new Date());
		client.setUpdateDate(new Date());
		// SMS 인증체크
		smsCertifyService.checkResult(client.getCertifyId());
		// BankAccount bankAccount = bankAccountService.loadOrCreate();
		// client.setBankAccId(bankAccount.getId());
		Long cyberAccountId = cyberAccountService.getCyberAccountId();
		client.setCyberAccId(cyberAccountId);

		repository.save(client);
	}

	/**
	 * 관리자 - 출금신청 목록 조회.
	 *
	 * @param search
	 * @param pageable
	 * @return
	 * @throws Exception
	 */
	public QueryResults<Tuple> getListByAdmin(WithdrawSearch search, Pageable pageable) throws Exception {
		QueryResults<Tuple> result = adminQuery.getListByEntity(search, pageable);

		return result;
	}

	/**
	 * 관리자 - 출금신청 조회.
	 *
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public Tuple getReadByAdmin(Long id) throws Exception {
		Tuple result = adminQuery.getReadByEntity(id);

		return result;
	}

	/**
	 * 관리자 - 출금신청 승인.
	 *
	 * @param client
	 * @throws Exception
	 */
	public void confirmByAdmin(Withdraw client) throws Exception {
		Withdraw server = repository.loadWithLock(client.getId());

		float amount = client.getConfirmPoint() / pointConfig.getRatioDollarToPoint();
		float fee = amount * (((float) pointConfig.getFeesPercent()) / 100);

		server.setConfirmPoint(client.getConfirmPoint());
		server.setAmount(amount);
		server.setFee(fee);
		server.setConfirmDate(client.getConfirmDate());
		server.setAdminComment(client.getAdminComment());
		server.setStatus(Withdraw.REGISTERED_STATUS);
		server.setAdminId(UserService.getMemberId());
		server.setUpdateDate(new Date());

		// 포인트 처리.
		cyberAccountService.insertPoint(server.getCyberAccId(), Point.WITHDREW_TYPE, server.getId(),
				server.getConfirmPoint());

		publisher.broadcast(new WithdrawEvent.Confirm(server));
	}

	/**
	 * 관리자 - 사용자에게 포인트를 출금 처리한다. 로그를 남기기 위해서 출금신청의 상태를 등록상태로 처리하고 포인트를 처리한다.
	 *
	 * @param client
	 * @throws Exception
	 */
	public void withdrawByAdmin(Withdraw client) throws Exception {
		client.setStatus(Withdraw.REGISTERED_STATUS);
		client.setInsertDate(new Date());
		client.setUpdateDate(new Date());
		client.setAdminId(UserService.getMemberId());

		repository.save(client);

		// 포인트 처리.
		cyberAccountService.insertPoint(client.getCyberAccId(), Point.ADMIN_WITHDREW_TYPE, client.getId(),
				client.getConfirmPoint());
	}

}