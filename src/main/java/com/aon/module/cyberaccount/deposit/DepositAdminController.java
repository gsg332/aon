package com.aon.module.cyberaccount.deposit;

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
@RequestMapping("/supervisor/module/deposit")
public class DepositAdminController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(DepositAdminController.class);

	@Autowired
	private DepositService service;

	@Autowired
	private DepositValidator validator;

	/**
	 * TODO : 권한처리
	 * 
	 * 충전신청 목록을 처리한다.
	 *
	 * @param pageable
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	@JsonView(BaseJsonView.Summary.class)
	public Model list(DepositSearch search, Pageable pageable, Model model) throws Exception {
		logger.debug("##### pageable : {}", pageable.toString());
		logger.debug("##### search : {}", search.toString());
		QueryResults<Tuple> result = service.getListByAdmin(search, pageable);

		List<Tuple> tList = result.getResults();
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();

		for (Tuple tuple : tList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("deposit", (Deposit) tuple.get(0, Deposit.class));
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
	 * TODO : 권한처리
	 * 
	 * 충전신청 조회를 처리한다.
	 *
	 * @param id
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/read")
	@JsonView(BaseJsonView.Summary.class)
	public Model read(Long id, Model model) throws Exception {
		Tuple result = service.getReadByAdmin(id);

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("deposit", (Deposit) result.get(0, Deposit.class));
		map.put("cyberAccount", (CyberAccount) result.get(1, CyberAccount.class));
		map.put("member", (Member) result.get(2, Member.class));

		model.addAttribute("item", map);

		return model;
	}

	/**
	 * TODO : 권한처리
	 * 
	 * 충전신청을 승인한다.
	 *
	 * @param client
	 * @param result
	 * @throws Exception
	 */
	@RequestMapping(value = "/update")
	@ResponseStatus(code = HttpStatus.OK)
	public void update(Deposit client, BindingResult result) throws Exception {
		logger.debug("##### Deposit : {}", client.toString());
		validator.validateConfirmAdmin(client, result);
		checkBindingResult(result);

		service.confirmByAdmin(client);
	}

	/**
	 * 관리자 포인트 입금.
	 * 
	 * 관리자가 사용에게 포인트를 입금(적립) 처리한다.
	 *
	 * @param deposit
	 * @throws Exception
	 */
	@RequestMapping(value = "/deposit")
	@ResponseStatus(code = HttpStatus.OK)
	public void deposit(Deposit client, BindingResult result) throws Exception {
		logger.debug("##### deposit : {}", client.toString());
		validator.validateDepositAdmin(client, result);
		checkBindingResult(result);

		service.depositByAdmin(client);
	}
}
