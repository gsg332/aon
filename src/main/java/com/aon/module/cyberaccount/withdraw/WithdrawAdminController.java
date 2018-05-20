package com.aon.module.cyberaccount.withdraw;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.aon.doc.BaseController;
import com.aon.doc.BaseJsonView;
import com.aon.module.cyberaccount.Admin;
import com.aon.module.cyberaccount.CyberAccount;
import com.aon.sys.member.Member;
import com.aon.sys.usr.User;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.QueryResults;
import com.querydsl.core.Tuple;

@Controller
@Secured(User.ROLE_ADMIN)
@RequestMapping("/supervisor/module/withdraw")
public class WithdrawAdminController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(WithdrawAdminController.class);

	@Autowired
	private WithdrawService service;

	@Autowired
	private WithdrawValidator validator;

	/**
	 * 출금신청 목록을 조회한다.
	 *
	 * @param search
	 * @param pageable
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	@JsonView(BaseJsonView.Summary.class)
	public Model list(WithdrawSearch search, Pageable pageable, Model model) throws Exception {
		QueryResults<Tuple> result = service.getListByAdmin(search, pageable);

		List<Tuple> tList = result.getResults();
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();

		for (Tuple tuple : tList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("withdraw", (Withdraw) tuple.get(0, Withdraw.class));
			map.put("cyberAccount", (CyberAccount) tuple.get(1, CyberAccount.class));
			map.put("member", (Member) tuple.get(2, Member.class));
			map.put("admin", (Admin) tuple.get(3, Admin.class));
			list.add(map);
		}

		model.addAttribute("list", list);
		model.addAttribute("count", result.getTotal());

		return model;
	}

	/**
	 * 출금신청을 조회한다.
	 *
	 * @param id
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/read")
	@JsonView(BaseJsonView.Summary.class)
	public Model read(Long id, Model model) throws Exception {
		logger.debug("id : {}", id);
		Tuple result = service.getReadByAdmin(id);

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("withdraw", (Withdraw) result.get(0, Withdraw.class));
		map.put("cyberAccount", (CyberAccount) result.get(1, CyberAccount.class));
		map.put("member", (Member) result.get(2, Member.class));
		model.addAttribute("item", map);

		return model;
	}

	/**
	 * 출금신청을 승인한다.
	 *
	 * @param client
	 * @param result
	 * @throws Exception
	 */
	@RequestMapping(value = "/update")
	@ResponseStatus(code = HttpStatus.OK)
	public void update(Withdraw client, BindingResult result) throws Exception {
		logger.debug("##### Withdraw : {}", client.toString());
		validator.validateAdmin(client, result);
		checkBindingResult(result);

		service.confirmByAdmin(client);
	}

	/**
	 * 관리자 포인트 출금.
	 * 
	 * 관리자가 사용자의 포인트를 출금(차감) 처리한다.
	 *
	 * @param deposit
	 * @throws Exception
	 */
	@RequestMapping(value = "/withdraw")
	@ResponseStatus(code = HttpStatus.OK)
	public void withdraw(Withdraw client, BindingResult result) throws Exception {
		logger.debug("##### withdraw : {}", client.toString());
		validator.validateWithdrawAdmin(client, result);
		checkBindingResult(result);

		service.withdrawByAdmin(client);
	}

}
