package com.aon.module.survey;

import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aon.doc.BaseController;
import com.aon.doc.BaseJsonView;
import com.aon.module.survey.user.SurveyUser;
import com.aon.module.survey.user.SurveyUserService;
import com.fasterxml.jackson.annotation.JsonView;

@Controller
@RequestMapping(value = "/module/survey/")
public class SurveyUserController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(SurveyUserController.class);

	@Autowired
	private SurveyQuery query;

	@Autowired
	private SurveyUserService userService;

	/**
	 * 회원 LIST JSON
	 * 
	 * @param page
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertSurvey")
	@JsonView(BaseJsonView.Summary.class)
	public void insertServey(HttpServletRequest req) throws Exception {
		Map<Object, Object> map = convertHashMap(req);
		Long surveyId = Long.parseLong(req.getParameter("surveyId")); // 질문 부모키를
		Long userId = null;
		String email = req.getParameter("email");
		String userName = req.getParameter("userName");
		String userLanguage = req.getParameter("userLanguage");

		if (email != null && !email.equals("")) {
			SurveyUser user = userService.create();
			user.setEmail(email);
			user.setUserName(userName);
			user.setSurveyId(surveyId);
			user.setInsertDate(new Date());
			user.setUserLanguage(userLanguage);
			userId = user.getId();
		}

		for (Object mapkey : map.keySet()) {
			if (!mapkey.equals("email") && !mapkey.equals("userName") && !mapkey.equals("userLanguage")) {
				Map<String, Object> paramMap = new HashMap<>();
				paramMap.put("surveyId", surveyId);
				paramMap.put("userId", userId);
				String key = (String) mapkey;
				String[] values = null; // 체크박스
				String value = null; // 라디오박스
				
				if (map.get(mapkey) instanceof String[]) {
					values = (String[]) map.get(mapkey);
				} else {
					value = (String) map.get(mapkey);
				}

				paramMap.put("questionCode", key);
				// 멀티 셀렉트 데이터
				if (values == null) {
					paramMap.put("value", value);
					if (key + "text" != null) {
						paramMap.put("textValue", req.getParameter(key + ("text")));
					}
					query.insertSurvey(paramMap);
				} else {
					for (int j = 0; j < values.length; j++) {
						paramMap.put("value", values[j]);
						if (j == (values.length - 1) && !"".equals(req.getParameter(key + ("text")))) {
							paramMap.put("textValue", req.getParameter(key + ("text")));
						}
						query.insertSurvey(paramMap);
					}
				}
			}
		}
	}
	
	@RequestMapping(value="/alreadyJoin")
	public Model  joinCheck(String email, Long surveyId, Model model) throws Exception{
		return model.addAttribute("alreadyJoin",query.joincheck(email, surveyId));
	}
	
	/**
	 * Request 객체를 통해 전달받은 변수들을 HashMap 형태로 만들어 리턴한다.<br />
	 *
	 * @param req
	 * @return HashMap<Object, Object>
	 */
	public static HashMap<Object, Object> convertHashMap(HttpServletRequest req) {
		HashMap<Object, Object> param = new HashMap<Object, Object>();

		String key = null;
		String[] values = null;
		Enumeration<String> enu = req.getParameterNames();
		while (enu.hasMoreElements()) {
			key = enu.nextElement().toString();
			values = req.getParameterValues(key);

			if (values.length > 1) {
				param.put(key, values);
			} else
				param.put(key, values[0]);
			logger.debug("key => " + key + "      value => " + values);
		}
		return param;
	}

	public static boolean isStringDouble(Object mapkey) {
		try {
			Double.parseDouble((String) mapkey);
			return true;
		} catch (NumberFormatException e) {
			return false;
		}
	}

}
