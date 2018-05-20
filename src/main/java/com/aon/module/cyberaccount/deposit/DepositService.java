package com.aon.module.cyberaccount.deposit;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.aon.lib.event.EventPublisher;
import com.aon.module.cyberaccount.CyberAccountService;
import com.aon.module.cyberaccount.point.Point;
import com.aon.sys.usr.UserService;
import com.querydsl.core.QueryResults;
import com.querydsl.core.Tuple;

@Service
public class DepositService {

	private static final Logger logger = LoggerFactory.getLogger(DepositService.class);

	@Autowired
	private IDepositRepository repository;

	@Autowired
	private CyberAccountService cyberAccountService;

	@Autowired
	private DepositAdminQuery adminQuery;

	@Autowired
	private EventPublisher publisher;

	// private PointConfig pointConfig = (PointConfig) ConfigService.getConfig(PointConfig.class);

	/**
	 * 충전신청을 등록한다.
	 *
	 * @param client
	 * @throws Exception
	 */
	public Deposit register(Deposit client) throws Exception {
		client.setStatus(Deposit.APPLIED_STATUS);
		client.setPaymentStatus(Deposit.PAY_WAIT_STATUS);
		client.setInsertDate(new Date());
		client.setUpdateDate(new Date());
		client.setCyberAccId(cyberAccountService.getCyberAccountId());

		return repository.save(client);
	}

	/**
	 * 관리자용
	 * 
	 * 충전신청 목록을 얻는다.
	 *
	 * @param pageable
	 * @return
	 * @throws Exception
	 */
	public QueryResults<Tuple> getListByAdmin(DepositSearch search, Pageable pageable) throws Exception {
		QueryResults<Tuple> result = adminQuery.getListByEntity(search, pageable);

		return result;
	}

	/**
	 * 관리자용
	 * 
	 * 충전신청을 조회한다.
	 *
	 * @param id
	 * @return
	 */
	public Tuple getReadByAdmin(Long id) throws Exception {
		Tuple result = adminQuery.getReadByEntity(id);

		return result;
	}

	/**
	 * 관리자용
	 * 
	 * 충전신청을 승인한다.
	 *
	 * @param client
	 * @throws Exception
	 */
	public void confirmByAdmin(Deposit client) throws Exception {
		Deposit server = repository.loadWithLock(client.getId());

		server.setConfirmPoint(client.getConfirmPoint());
		// server.setAmount(((float) client.getConfirmPoint()) / pointConfig.getRatioDollarToPoint());
		// server.setConfirmAccountName(client.getConfirmAccountName());
		server.setConfirmDate(new Date());
		server.setAdminComment(client.getAdminComment());
		server.setStatus(Deposit.REGISTERED_STATUS);
		server.setAdminId(UserService.getMemberId());
		server.setUpdateDate(new Date());

		logger.debug("deposit server : {}", server.toString());

		// 포인트 처리
		cyberAccountService.insertPoint(server.getCyberAccId(), Point.DEPOSITED_TYPE, server.getId(),
				server.getConfirmPoint());

		publisher.broadcast(new DepositEvent.Confirm(server));
	}

	/**
	 * 관리자용
	 * 
	 * 관리자가 사용자에게 포인트를 입금 처리한다. 로그를 남기기 위해서 충전신청의 상태를 등록상태로 처리하고 포인트를 처리한다.
	 *
	 * @param client
	 */
	public void depositByAdmin(Deposit client) throws Exception {
		client.setStatus(Deposit.REGISTERED_STATUS);
		client.setInsertDate(new Date());
		client.setUpdateDate(new Date());
		client.setAdminId(UserService.getMemberId());

		repository.save(client);

		cyberAccountService.insertPoint(client.getCyberAccId(), Point.ADMIN_DEPOSITED_TYPE, client.getId(),
				client.getConfirmPoint());
	}

	/**
	 * paypal에서 callback url로 넘겨주는 결제고유번호를 update한다.
	 *
	 * @param id
	 * @param paymentId
	 * @return
	 */
	public Deposit updatePaymentId(Long id, String paymentId) {
		Deposit server = repository.getOne(id);
		server.setPaymentId(paymentId);
		repository.save(server);
		
		return server;
	}
}
