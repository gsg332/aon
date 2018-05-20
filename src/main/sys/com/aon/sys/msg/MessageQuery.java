package com.aon.sys.msg;

import java.math.BigInteger;
import java.util.List;

import org.springframework.stereotype.Service;

import com.aon.lib.jpa.Query;
import com.aon.lib.tree.Node;
import com.aon.sys.usr.UserService;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQuery;

@Service
public class MessageQuery extends Query {

	public int getRcvdDateCnt() throws Exception {
		StringBuffer query = new StringBuffer();
		query.append("SELECT count(message_id) FROM sa_message_receiver ");
		query.append("WHERE member_id = ? AND is_notified = 0 ");
	   return ((BigInteger) createNativeQuery(query.toString()).setParameter(1,UserService.getMemberId()).getSingleResult()).intValue();
	} 

	/***
	 * 내알림목록을 가져온다. 
	 * 1:n 관계에서 inner 조인 예제로 활용할것 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Message> getList(Long id) throws Exception{
		QMessage message = QMessage.message;
		QMessage_Receiver receiver = QMessage_Receiver.receiver;
		JPAQuery<?> query = getQuery();
		
		BooleanExpression searchQuery = null;

		if(id != null && id > 0){
			searchQuery = message.id.lt(id);
		}
		
		return (List<Message>) query
			.from(message).innerJoin(message.receivers,receiver)
			.where(receiver.deleted.eq(false)).where(receiver.memberId.eq(UserService.getMemberId()))
			.where(searchQuery)
			.orderBy(message.sendedDate.desc())
			.limit(5)
			.fetch();
	}
	
	@SuppressWarnings("unchecked")
	public List<Message> getListAll() throws Exception{
		QMessage message = QMessage.message;
		QMessage_Receiver receiver = QMessage_Receiver.receiver;
		JPAQuery<?> query = getQuery();
		
		return (List<Message>) query
			.from(message).innerJoin(message.receivers,receiver)
			.where(receiver.memberId.eq(UserService.getMemberId()))
			.fetch();
	}
	
	public int readCheck(String ids) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" update sa_message_receiver ");
		sb.append(" set receive_date = sysdate(), is_notified = true ");
		sb.append(" where message_id in (" + ids + ") ");

		return createNativeQuery(sb.toString())
				.executeUpdate();
	}
	
}
