package com.aon.doc.reply;

import java.util.List;

import com.aon.doc.BaseDoc;
import com.aon.lib.jpa.ClassMetaData;
import com.aon.lib.jpa.EntityManagerService;

class ReplyCount
{
	private String _increase;
	private String _decrease;
	private String _selReply;
	private String _selReplyExcl;
	private String _selParent;

	ReplyCount(Class<?> clazz)
	{
		String tableName = ClassMetaData.getTableName(clazz);
		String identifier =  ClassMetaData.getIdentifierCoulumnName(clazz);

		StringBuffer increase = new StringBuffer();
		increase.append("UPDATE ");
		increase.append(tableName);
		increase.append(" SET reply_count = reply_count + 1 ");
		increase.append(" WHERE ");
		increase.append(identifier); 
		increase.append(" = ? ");
		_increase = increase.toString();

		StringBuffer decrease = new StringBuffer();
		decrease.append("UPDATE ");
		decrease.append(tableName);
		decrease.append(" SET reply_count = reply_count - 1 ");
		decrease.append(" WHERE ");
		decrease.append(identifier); 
		decrease.append("= ? ");
		_decrease = decrease.toString();

		StringBuffer selReply = new StringBuffer();
		selReply.append("SELECT ");
		selReply.append(identifier);
		selReply.append(" FROM ");
		selReply.append(tableName);
		selReply.append(" WHERE parentid = ? ");
		_selReply = selReply.toString();

		StringBuffer selReplyExcl = new StringBuffer();
		selReplyExcl.append("SELECT ");
		selReplyExcl.append(identifier);
		selReplyExcl.append(" FROM ");
		selReplyExcl.append(tableName);
		selReplyExcl.append(" WHERE parentid = ? ");
		selReplyExcl.append("AND status <> ? ");
		_selReplyExcl = selReplyExcl.toString();

		StringBuffer selParent = new StringBuffer();
		selParent.append("SELECT ");
		selParent.append(identifier);
		selParent.append(" FROM ");
		selParent.append(tableName);
		selParent.append(" WHERE ");
		selParent.append(identifier); 
		selParent.append("= ? ");
		selParent.append("AND status <> ? ");
		_selParent = selParent.toString();
	}

	void increaseRplyCnt(Long id) throws Exception
	{
		EntityManagerService.createNativeQuery(_increase)
		.setParameter(1, id)
		.executeUpdate();
	}

	void decreaseRplyCnt(Long id) throws Exception
	{
		EntityManagerService.createNativeQuery(_decrease)
		.setParameter(1, id)
		.executeUpdate();
	}

	boolean hasReply(Long id) throws Exception
	{
		List<?> result = EntityManagerService.createNativeQuery(_selReply)
		.setParameter(1, id).getResultList();
		return (!result.isEmpty());
	}

	boolean hasReplyExclOfStatus(Long id) throws Exception
	{
		List<?> result = EntityManagerService.createNativeQuery(_selReplyExcl)
		.setParameter(1, id)
		.setParameter(2, BaseDoc.DELETED_STATUS)
		.getResultList();
		return (!result.isEmpty());
	}

	boolean hasParent(Long id) throws Exception
	{
		List<?> result = EntityManagerService.createNativeQuery(_selParent)
				.setParameter(1, id)
				.setParameter(2, BaseDoc.DELETED_STATUS)
				.getResultList();
		return (!result.isEmpty());
	}

}
