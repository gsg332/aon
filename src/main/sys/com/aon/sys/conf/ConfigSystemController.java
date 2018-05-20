package com.aon.sys.conf;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.aon.doc.BaseController;
import com.aon.doc.BaseJsonView;
import com.aon.lib.i18n.I18nService;
import com.aon.sys.usr.User;
import com.fasterxml.jackson.annotation.JsonView;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@Secured(User.ROLE_ADMIN)
@RequestMapping("/system/config")
public class ConfigSystemController extends BaseController {

	private static ConfigManager manager;
	@Override
	public void init() {
		manager = new ConfigManager();
	}
	
	@RequestMapping(value = "/list")
	public Model list(Model model){
		return model.addAttribute("result", ConfigCache.getAllProperties());
	}
	
	@RequestMapping(value="/update")
	@ResponseStatus(code = HttpStatus.OK)
	public void update(HttpServletRequest request) throws Exception{
		List<Config> configList = new ArrayList<Config>();
		Map<String, String[]> requestMap = request.getParameterMap();
		
		Enumeration<String> enumData = request.getParameterNames();
		
		while(enumData.hasMoreElements()){
			String pName = enumData.nextElement();
			if(!pName.equals("_csrf")){
				String pValue = "";
				String[] pValues = request.getParameterValues(pName);
				pValue = pValues[0];
				
				Config config = new Config();
				config.setKey(pName);
				config.setValue(pValue);
				configList.add(config);
			}
		}
		
		/*
		List<Config> configList = new LinkedList<Config>();
		Config c1 = new Config();
		c1.setKey("com.aon.module.doc.DocItemConfig.sampleString");
		c1.setValue("안녕하세요.....수정");
		Config c2 = new Config();
		c2.setKey("com.aon.module.doc.DocItemConfig.sampleInt");
		c2.setValue("10000");
		Config c3 = new Config();
		c3.setKey("com.aon.module.doc.DocItemConfig.sampleLong");
		c3.setValue("11");
		configList.add(c1);
		configList.add(c2);
		configList.add(c3);
		*/
		manager.updateConfigList(configList);
	}
	
	@RequestMapping(value = "/classList")
	public Model classList(String clazz, Model model) throws ClassNotFoundException{
		
		//clazz에 대한 메소드 필드명 및  uiannotaion을 리턴한다.
		//	[{ 'com.aon.module.doc.DocItemConfig.xxxx' ,'INPUT','value'},{}]
		//=>화면에서 받아서 ...수정화면을 작성한다.
		//System.out.println(clazz);
		model.addAttribute("list", ConfigService.getKeyAndUI(Class.forName(clazz)));
		return model;
	}
	
	@RequestMapping(value = "/classRead")
	public Model classRead(String clazz, Model model) throws ClassNotFoundException{
		model.addAttribute("key", clazz);
		model.addAttribute("value", ConfigService.getProperty(clazz));
		return model;
	}
	
	@RequestMapping(value="/messageUpdate")
	@ResponseStatus(code = HttpStatus.OK)
	public void messageUpdate(HttpServletRequest request) throws Exception{
		List<Config> configList = new ArrayList<Config>();
		
		List<String> locales = I18nService.getLocales();
		Map<String, Object> map = new HashMap<String, Object>();
		for (int i = 0; i < locales.size(); i++) {
			map.put(locales.get(i), request.getParameter(locales.get(i)));
		}
		map.put("className", request.getParameter("className"));
		ObjectMapper mapper = new ObjectMapper();
		
		Config config = new Config();
		config.setKey(request.getParameter("key"));
		config.setValue(mapper.writeValueAsString(map));
		configList.add(config);
		
		manager.updateConfigList(configList);
	}
	
}
