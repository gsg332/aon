package com.aon.module.cyberaccount.deposit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aon.doc.BaseController;
import com.aon.module.cyberaccount.point.PointConfig;
import com.aon.module.paypal.PaypalSpring;
import com.aon.sys.conf.ConfigService;

@Controller
@RequestMapping("/module/deposit")
public class DepositUserController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(DepositUserController.class);
	private static PointConfig pointConfig = (PointConfig) ConfigService.getConfig(PointConfig.class);

	@Autowired
	private DepositService service;

	@Autowired
	private DepositValidator validator;

	/**
	 * 충전신청
	 *
	 * @param client
	 * @param result
	 * @throws Exception
	 */
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	@ResponseStatus(code = HttpStatus.OK)
	public void register(Deposit client, BindingResult result) throws Exception {
		logger.debug("##### deposit client : {}", client.toString());
		validator.validate(client, result);
		checkBindingResult(result);

		service.register(client);
	}

	@RequestMapping(value = "/paypal")
	public String paypal(Deposit client, BindingResult result, RedirectAttributes redirect) throws Exception {
		validator.validate(client, result);
		checkBindingResult(result);

		Deposit server = service.register(client);

		redirect.addAttribute("cmd", "_xclick");
		redirect.addAttribute("business", PaypalSpring.getBusinessEmail());
		redirect.addAttribute("item_name", "Whatinfo points");
		redirect.addAttribute("item_number", server.getId().toString());
		redirect.addAttribute("currency_code", "USD");
		redirect.addAttribute("amount", server.getRequestPoint() / pointConfig.getRatioDollarToPoint());
		redirect.addAttribute("charset", "UTF-8");

		return "redirect:" + PaypalSpring.getPaymentUrl();
	}
}
