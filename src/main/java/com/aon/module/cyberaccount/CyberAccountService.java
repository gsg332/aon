package com.aon.module.cyberaccount;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.aon.module.cyberaccount.CyberAccountException.InvalidParameterException;
import com.aon.module.cyberaccount.CyberAccountException.NotEnoughException;
import com.aon.module.cyberaccount.point.Point;
import com.aon.module.cyberaccount.point.PointService;
import com.aon.sys.usr.UserService;

@Service
public class CyberAccountService extends PointService {

	private static final Logger logger = LoggerFactory.getLogger(CyberAccountService.class);

	@Autowired
	private ICyberAccountRepository repository;

	/**
	 * 주어진 회원일련번호로 포인트를 적립/차감한다.
	 *
	 * @param pointType
	 * @param sourceId
	 * @param point
	 * @param memberId
	 * @throws Exception
	 */
	public void insertPoint(int pointType, Long sourceId, Long point, Long memberId) throws Exception {
		CyberAccount cyberAccount = repository.findByMemberId(memberId);
		Point pointObj = getPointObject(pointType, sourceId, point);

		// 가상계좌 및 포인트의 데이터 처리
		processPoint(pointObj, cyberAccount);

	}

	/**
	 * 주어진 가상계좌일련번호로 포인트를 적립/차감한다.
	 *
	 * @param cyberAccId
	 * @param pointType
	 * @param sourceId
	 * @param point
	 * @throws Exception
	 */
	public void insertPoint(Long cyberAccId, int pointType, Long sourceId, Long point) throws Exception {
		CyberAccount cyberAccount = repository.findOne(cyberAccId);
		Point pointObj = getPointObject(pointType, sourceId, point);

		// 가상계좌 및 포인트의 데이터 처리
		processPoint(pointObj, cyberAccount);
	}

	/**
	 * 로그인 사용자의 포인트 사용이 가능한지 체크한다.
	 *
	 * @throws Exception
	 */
	public void checkBalance(Long point) throws Exception {
		CyberAccount cyberAccount = getCyberAccount();
		if (point > 0) {
			point = point * -1;
		}

		if (point + cyberAccount.getBalance() < 0) {
			throw new NotEnoughException();
		}

	}

	/**
	 * 가상계좌를 생성하여 저장하고 객체를 돌려준다.
	 *
	 * @param memberId
	 * @param countryCode
	 * @return
	 * @throws Exception
	 */
	public CyberAccount create(Long memberId, String countryCode) throws Exception {
		if (StringUtils.isEmpty(memberId) || StringUtils.isEmpty(countryCode)) {
			throw new InvalidParameterException();
		}
		String cyberAccNumber = makeAccountNumber(memberId, countryCode);

		CyberAccount cyberAccount = new CyberAccount();
		cyberAccount.setCyberAccNumber(cyberAccNumber);
		cyberAccount.setMemberId(memberId);

		repository.save(cyberAccount);

		return cyberAccount;
	}

	/**
	 * 로그인 사용자의 가상계좌를 얻는다.
	 *
	 * @return
	 * @throws Exception
	 */
	public CyberAccount getCyberAccount() throws Exception {
		return repository.findByMemberId(UserService.getMemberId());
	}

	/**
	 * 로그인 사용자의 가상계좌일련번호를 얻는다.
	 *
	 * @return
	 * @throws Exception
	 */
	public Long getCyberAccountId() throws Exception {
		return repository.findByMemberId(UserService.getMemberId()).getId();
	}

	/**
	 * !! 호출하는 쪽에서 권한체크는 필수 !! 회원일련번호로 가상계좌를 얻는다.
	 *
	 * @param memberId
	 * @return
	 * @throws Exception
	 */
	public CyberAccount getCyberAccount(Long memberId) throws Exception {
		return repository.findByMemberId(memberId);
	}

	/**
	 * !! 호출하는 쪽에서 권한체크는 필수 !! 회원일련번호로 가상계좌일련번호를 얻는다.
	 *
	 * @param memberId
	 * @return
	 * @throws Exception
	 */
	public Long getCyberAccountId(Long memberId) throws Exception {
		return repository.findByMemberId(memberId).getId();
	}
	
	/**
	 * 가상계좌일련번호로 회원가상계좌를 얻는다.
	 *
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public CyberAccount getCyberAccountById(Long id) throws Exception {
		return repository.findOne(id);
	}

	/**
	 * 17자리 가상계좌번호를 생성한다.
	 * 
	 * 3자리 - 국가코드(ISO 3166-1 NUMERIC) 8자리 - reverse(년yyyy)+reverse(월mm)+reverse(일dd) 6자리 - 회원일련번호 뒷 6자리(zerofill)
	 *
	 * @param memberId
	 * @param countryCode
	 * @return
	 * @throws Exception
	 */
	protected String makeAccountNumber(Long memberId, String countryCode) throws Exception {
		String reverseDate = CyberAccountUtil.getReverseDate();
		String memIdStr = CyberAccountUtil.get6ZerofillMemberId(memberId);
		String countryNumericCode = CyberAccountUtil.get3ZerofillCountryNumericCode(countryCode);
		String cyberAccountNumber = countryNumericCode + reverseDate + memIdStr;

		return cyberAccountNumber;
	}

	/**
	 * 포인트 유형에 따라서 잔액을 체크하고 가상계좌의 sum column data를 update한다.
	 *
	 * @param pointObj
	 * @param cyberAccount
	 * @throws Exception
	 */
	private void processPoint(Point pointObj, CyberAccount cyberAccount) throws Exception {
		pointObj.setCyberAccId(cyberAccount.getId());

		Long beforBalance = cyberAccount.getBalance();
		if (pointObj.getType() < 0) {
			if (pointObj.getPoint() > 0) {
				pointObj.setPoint(pointObj.getPoint() * -1);
			}
			// 잔액체크
			checkBalance(pointObj, cyberAccount);
			// - 합계 처리.
			cyberAccount.setWithdrawSum(cyberAccount.getWithdrawSum() + pointObj.getPoint());
		} else {
			// + 합계 처리.
			cyberAccount.setDepositSum(cyberAccount.getDepositSum() + pointObj.getPoint());
			// 채택으로 받는 합계 처리.
			if (pointObj.getType() == Point.CHOSE_TYPE) {
				cyberAccount.setChooseSum(cyberAccount.getChooseSum() + pointObj.getPoint());
			}
		}
		pointObj.setBalance(beforBalance + pointObj.getPoint());

		super.insertPoint(pointObj);
	}

	/**
	 * 잔액체크
	 *
	 * @param pointObj
	 * @param cyberAccount
	 * @throws Exception
	 */
	private void checkBalance(Point pointObj, CyberAccount cyberAccount) throws Exception {
		if (pointObj.getPoint() + cyberAccount.getBalance() < 0) {
			throw new NotEnoughException();
		}
	}

	private Point getPointObject(int pointType, Long sourceId, Long point) throws Exception {
		Point pointObj = new Point();
		pointObj.setType(pointType);
		pointObj.setSourceId(sourceId);
		pointObj.setPoint(point);
		pointObj.setInsertDate(new Date());

		return pointObj;
	}
}
