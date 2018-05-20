package com.aon.module.doc;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.aon.doc.file.AttachmentManager;
import com.aon.lib.event.EventPublisher;
import com.aon.module.doc.DocItem.Attachment;
import com.aon.sys.usr.UserService;


@Service
public class DocItemService {

	@Autowired
	private AttachmentManager<Attachment> attachment;

	@Autowired
	private IDocItemRepository repository;

	@Autowired
	private EventPublisher publisher;

	public Page<DocItem> list(Pageable page) {

		return repository.findAllByOrderByInsertDateDesc(page);
	}

	public DocItem loadOrCreate(Long id) {
		if (id == null) {
			return repository.create(new DocItem());
		}
		return repository.loadWithLock(id);
	}

	public void register(DocItem server) throws Exception {

		// TODO:현재사용자 받아올것
		// server.setRegisterUser(new User(new Long(1),"testuer"));
		server.setRegisterUser(UserService.getUser());
		server.setInsertDate(new Date());
		server.setUpdateDate(new Date());
		server.setStatus(DocItem.REGISTERED_STATUS);
		server.updateVisible(true);
		publisher.broadcast(new DocItemEvent.Create(server));
	}

	public void update(DocItem server, DocItem client) throws Exception {

		// 버전 비교하여 exception발생
		server.checkVersion(client.getVersion());

		server.setTitle(client.getTitle());
		server.setContent(client.getContent());
		server.updateAttachments(attachment.update(client.getAttachments(), server));
		updateCategories(server,client);
		server.setGroupId(client.getGroupId());
		server.setParentId(client.getParentId());
		server.setUpdateDate(new Date());
		server.updateVisible(server.isVisible());

	}
	
	private static void updateCategories(DocItem server, DocItem client) throws Exception
	{
		server.setCategories(client.getCategories());
		server.updateFolderLevel();

	}

	public void remove(DocItem server) throws Exception {
		attachment.remove(server.getAttachments());
		repository.delete(server);
		publisher.broadcast(new DocItemEvent.Delete(server));

	}

}
