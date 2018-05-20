package com.aon.module.bankaccount;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aon.doc.BaseController;
import com.aon.doc.BaseJsonView;
import com.aon.doc.Permission;
import com.fasterxml.jackson.annotation.JsonView;

@Controller
@RequestMapping(value = "/supervisor/module/bankAccount/")
public class BankAccountAdminController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(BankAccountAdminController.class);

	@Autowired
	private BankAccountService service;

	private Permission permission;

	@Override
	public void init() {
		permission = new Permission();
	}

	/**
	 * 유저(BankAccount)정보조회
	 * 
	 * @param member
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getBankAccount")
	@JsonView(BaseJsonView.Summary.class)
	public Model getBankAccount(Model model) throws Exception {
		BankAccount bankAccount = service.loadOrCreate();
		model.addAttribute("bankAccount", bankAccount);
		return model;
	}

	@RequestMapping(value = "/getBankAccountInfo")
	@JsonView(BaseJsonView.Summary.class)
	public Model getBankAccount(Model model, Long id) throws Exception {
		BankAccount bankAccount = service.loadOrCreate(id);
		model.addAttribute("bankAccount", bankAccount);
		return model;
	}
}
