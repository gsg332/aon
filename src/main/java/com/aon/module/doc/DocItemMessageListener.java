package com.aon.module.doc;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.aon.module.doc.DocItemEvent.Create;
import com.aon.module.doc.DocItemEvent.Delete;
import com.aon.sys.conf.ConfigService;
import com.aon.sys.msg.MessageService;
import com.aon.sys.usr.User;
import com.aon.sys.usr.UserService;

@Component
public class DocItemMessageListener implements IDocItemListener {

	@Override
	public void create(Create e) throws Exception {

		Map<String, Object> m = new HashMap<String, Object>();
		//test용으로 자기자신에게 보낸다. 
		User receiver =  ((DocItem) e.getSource()).getRegisterUser();
		m.put("receiver", ((DocItem) e.getSource()).getRegisterUser());
		m.put("title", ((DocItem) e.getSource()).getTitle());
		m.put("id", ((DocItem) e.getSource()).getId());
		m.put("sender", UserService.getUser().getDisplayName());
		
		String content = ConfigService.merge(DocItemMessageConfig.REGISTER, m);
		MessageService.send(content, receiver);

	}

	@Override
	public void delete(Delete e) throws Exception {

	}

}
