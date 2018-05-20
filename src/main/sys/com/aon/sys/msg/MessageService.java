package com.aon.sys.msg;

import java.util.Collection;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.aon.sys.usr.User;
import com.aon.sys.usr.UserService;

/**
 * 알림 메시지 처리 
 */
@Component 
public class MessageService
{
	private static MessageQuery query;
	
	private static IMessageRepository repository;
	
	@Autowired
	public  void setRepository(IMessageRepository repository) {
		MessageService.repository = repository;
	}

	@Autowired 
	public  void setQuery(MessageQuery query){
		MessageService.query = query;
	}
	
	public List<Message> getList(Long id) throws Exception{
		return query.getList(id);
	}
	
	public void setReadCheck(String ids) throws Exception{
		query.readCheck(ids);
	}
	
	public static void send(Message message,Collection<User> receivers) throws Exception
	{
		message.setSender(UserService.getUser());
		message.setSendedDate(new Date());
		message.setUpdateDate(new Date());
		message.setReceivers(new LinkedList<Message.Receiver>());
		for(User user:receivers){
			Message.Receiver r = new Message.Receiver();
			r.setMemberId(user.getMemberId());
			r.setDisplayName(user.getDisplayName());
			message.getReceivers().add(r);
		}
		int size = (message.getReceivers() != null) ? message.getReceivers().size() : 0;
		message.setReceiverCount(size);
		message.setReadCount(size);
		repository.save(message);
		
	}
	
	public static void send(Message message,User receiver) throws Exception
	{
		 List<User> receivers = new LinkedList<User>();
		 receivers.add(receiver);
		 send(message,receivers);
		
	}
	
	public static void send(String content,User receiver) throws Exception
	{
		 List<User> receivers = new LinkedList<User>();
		 Message message = new Message();
		 message.setContent(content);
		 receivers.add(receiver);
		 send(message,receivers);
		
	}
	

	/**
	 * 수신메시지를 삭제한다.
	 * <p>
	 * 수신자들이 모두 삭제할 경우 메시지가 삭제 된다.
	 * @param msgId
	 */
	void deleteByReceiver(Long msgId) throws Exception
	{
		Message message = (Message) query.find(Message.class, msgId);
		Long memberId = UserService.getMemberId();
		for (Message.Receiver r : message.getReceivers())
		{
			if (r.getMemberId().equals(memberId))
			{
				r.setDeleted(true);
			}
		}
		if (message.isRemoved())
		{
			repository.delete(message);
		}
	}
	
	
	public  int getNewMsgCount() throws Exception
	{
		return query.getRcvdDateCnt();
	}
	
	void deleteAllByReceiver() throws Exception
	{
		List<Message> messages = query.getListAll();
		for(Message message : messages){
			for (Message.Receiver r : message.getReceivers())
			{
				r.setDeleted(true);
			}
			if (message.isRemoved())
			{
				repository.delete(message);
			}
		}
	}

}
