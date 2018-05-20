package com.aon.sys.msg;

import java.util.Date;
import java.util.List;

import com.aon.doc.BaseJsonView;
import com.aon.doc.BaseObject;
import com.aon.sys.usr.User;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.annotations.QueryEntity;


@QueryEntity
public class Message extends BaseObject
{
	private static final long serialVersionUID = -6885694943639713540L;
	
	@JsonView(BaseJsonView.Summary.class)
	private User sender;
	
	@JsonView(BaseJsonView.Summary.class)
	private Date sendedDate;
	
	@JsonView(BaseJsonView.Summary.class)
	private Date updateDate;
	
	@JsonView(BaseJsonView.Summary.class)
	private String content;
	private int receiverCount;
	private int readCount;
	
	@JsonView(BaseJsonView.Summary.class)
	private List<Receiver> receivers;
	
	public List<Receiver> getReceivers() {
		return receivers;
	}

	public void setReceivers(List<Receiver> receivers) {
		this.receivers = receivers;
	}

	public User getSender() {
		return sender;
	}

	public void setSender(User sender) {
		this.sender = sender;
	}

	public Date getSendedDate() {
		return sendedDate;
	}

	public void setSendedDate(Date sendedDate) {
		this.sendedDate = sendedDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getReceiverCount() {
		return receiverCount;
	}

	public void setReceiverCount(int receiverCount) {
		this.receiverCount = receiverCount;
	}

	public int getReadCount() {
		return readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	
	public boolean isRemoved()
	{
		
		for (Receiver r : getReceivers())
		{
			if (!r.isDeleted)
			{
				return false;
			}
		}
		return true;
	}

	@QueryEntity
	public static class Receiver extends User
	{
		private static final long serialVersionUID = 9181765557760896690L;

		private Date receiveDate;
		
		@JsonView(BaseJsonView.Summary.class)
		private boolean isNotified;
		private boolean isDeleted;

		public Receiver()
		{
		}

		public Receiver(User receiver)
		{
			super(receiver);
		}

		public Date getReceiveDate() {
			return receiveDate;
		}

		public void setReceiveDate(Date receiveDate) {
			this.receiveDate = receiveDate;
		}

		public boolean isNotified() {
			return isNotified;
		}

		public void setNotified(boolean isNotified) {
			this.isNotified = isNotified;
		}

		public boolean isDeleted() {
			return isDeleted;
		}

		public void setDeleted(boolean isDeleted) {
			this.isDeleted = isDeleted;
		}
		
	}

	
}
