package com.aon.module.cyberaccount;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aon.doc.BaseController;
import com.aon.doc.BaseJsonView;
import com.aon.module.cyberaccount.point.Point;
import com.aon.module.cyberaccount.point.PointService;
import com.fasterxml.jackson.annotation.JsonView;

@Controller
@RequestMapping("/module/cyberAccount")
public class CyberAccountUserController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(CyberAccountUserController.class);

	@Autowired
	private CyberAccountService service;

	@Autowired
	private PointService pointService;

	/**
	 * 가상계좌와 포인트 거래내역을 조회한다.
	 *
	 * @param model
	 * @param pageable
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/all")
	@JsonView(BaseJsonView.Summary.class)
	public Model view(Model model, Pageable pageable) throws Exception {
		// 로그인한 사용자의 가상계좌를 얻는다.
		CyberAccount cyberAccount = service.getCyberAccount();
		logger.debug("##### cyberAccount : {}", cyberAccount.toString());

		// 가상계좌번호를 통해 페이징 처리된 포인트 리스트를 얻는다.
		logger.debug("##### pageable : {}", pageable.toString());
		Page<Point> points = pointService.getList(cyberAccount.getId(), pageable);
		logger.debug("##### points : {}", points.toString());

		model.addAttribute("cyberAccount", cyberAccount);
		model.addAttribute("points", points);
		model.addAttribute("pointsCount", points.getTotalElements());

		return model;
	}

	/**
	 * 로그인 한 사용자의 CyberAccount를 얻는다.
	 *
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/read")
	@JsonView(BaseJsonView.Summary.class)
	public Model getAll(Model model) throws Exception {
		// 로그인한 사용자의 가상계좌를 얻는다.
		CyberAccount cyberAccount = service.getCyberAccount();
		logger.debug("##### cyberAccount : {}", cyberAccount.toString());

		model.addAttribute("cyberAccount", cyberAccount);

		return model;
	}	
}
