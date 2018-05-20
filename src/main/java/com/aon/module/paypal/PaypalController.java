package com.aon.module.paypal;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.aon.doc.BaseController;
import com.aon.module.cyberaccount.deposit.Deposit;
import com.aon.module.cyberaccount.deposit.DepositService;

@Controller
@RequestMapping("/external")
public class PaypalController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(PaypalController.class);

	@Autowired
	PaypalService service;

	@Autowired
	DepositService depositService;

	/**
	 * 사용자가 결제를 완료하면 페이팔에서 호출하는 callback url.
	 * 
	 * 대부분 같으나 결제고유번호는 PDT(sync) 방식과 IPN(async) 방식에 따라서 return parameter의 key가 다름으로 주의!!
	 * PDT : tx=6X84449760262301V
	 * IPN : txn_id=8E9587271F929780B
	 *
	 * @param map
	 * @throws Exception
	 */
	@RequestMapping(value = "/callback2paypal")
	public void callback2paypal(@RequestParam HashMap<String, String> map) throws Exception {
		Long id = new Long(map.get("item_number"));
		String tx = map.get("txn_id").toString();
		
		// 결제고유번호를 update한다.
		Deposit server = depositService.updatePaymentId(id, tx);

		String params = "cmd=_notify-synch&tx=" + tx + "&at=" + PaypalSpring.getBusinessToken();
		
		// 결제고유번호를 가지고 결제가 정상적으로 처리되었는지 조회한다.
		Map<String, String> resMap = service.getPayInfo(params);

		if ("SUCCESS".equals(resMap.get("result"))) {
			server.setPaymentStatus(Deposit.PAY_SUCCESS_STATUS);
			server.setPayerEmail(resMap.get("payer_email").toString());
			server.setPaymentDate(resMap.get("payment_date").toString());
			server.setPaymentFee(new Float(resMap.get("payment_fee")));
			server.setAmount(new Float(resMap.get("payment_gross")));
			server.setUpdateDate(new Date());
		} else {
			server.setStatus(Deposit.REGISTERED_STATUS);
			server.setPaymentStatus(Deposit.PAY_FAIL_STATUS);
			server.setUpdateDate(new Date());
		}
	}
}
