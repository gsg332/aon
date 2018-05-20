package com.aon.doc;

import java.util.Date;

import com.aon.sys.usr.User;
import com.aon.sys.usr.UserService;
import com.fasterxml.jackson.annotation.JsonGetter;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonView;

@JsonInclude(value = Include.NON_NULL)
public abstract class BaseDoc extends BaseObject {

	private static final long serialVersionUID = 7484663272260444428L;

	@JsonView(BaseJsonView.Summary.class)
	private Date insertDate;

	@JsonView(BaseJsonView.Summary.class)
	private Date updateDate;

	@JsonView(BaseJsonView.Summary.class)
	private String title;

	@JsonView(BaseJsonView.Detail.class)
	private String content;

	private int readCount;

	@JsonView(BaseJsonView.Summary.class)
	@JsonProperty("readCount")
	private int transientCount;

	@JsonView(BaseJsonView.Detail.class)
	private Long groupId;

	@JsonView(BaseJsonView.Detail.class)
	private Long parentId;

	@JsonView(BaseJsonView.Summary.class)
	private int position;

	@JsonView(BaseJsonView.Summary.class)
	private int step;

	@JsonView(BaseJsonView.Summary.class)
	private int replyCount;

	private int status;

	private boolean visible;

	@JsonView(BaseJsonView.Summary.class)
	private User registerUser;

	private int flagCode;

	@JsonGetter("readCount")
	public int getTransientCount() {
		return (transientCount == 0 ? getReadCount() : transientCount);
	}

	public void setTransientCount(int transientCount) {
		this.transientCount = transientCount;
	}

	public Date getInsertDate() {
		return this.insertDate;
	}

	public void setInsertDate(Date insertDate) {
		this.insertDate = insertDate;
	}

	public Date getUpdateDate() {
		return this.updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getReadCount() {
		return this.readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	public Long getGroupId() {
		return groupId;
	}

	public void setGroupId(Long groupId) {
		this.groupId = groupId;
	}

	public Long getParentId() {
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}

	public int getPosition() {
		return position;
	}

	public void setPosition(int position) {
		this.position = position;
	}

	public int getStep() {
		return step;
	}

	public void setStep(int step) {
		this.step = step;
	}

	public int getReplyCount() {
		return replyCount;
	}

	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public boolean isVisible() {
		return visible;
	}

	public void setVisible(boolean visible) {
		this.visible = visible;
	}

	public User getRegisterUser() {
		return registerUser;
	}

	public void setRegisterUser(User registerUser) {
		this.registerUser = registerUser;
	}

	public int getFlagCode() {
		return flagCode;
	}

	public void setFlagCode(int flagCode) {
		this.flagCode = flagCode;
	}

	public boolean isFlagCode(int code) {
		return ((this.flagCode & code) != 0);
	}

	public boolean isReply() {
		return (parentId != null && groupId != null && !groupId.equals(getId()));
	}

	public void updateVisible(boolean visible) {
		setVisible(visible);
	}
	
	
	public boolean isCurrentRgstUser() throws Exception
	{
		Long memberId = UserService.getMemberId();
		if (memberId == null)
		{
			return false;
		}
		
		User rgst = getRegisterUser();
		if (rgst == null)
		{
			return false;
		}
		return (memberId.equals(rgst.getMemberId()));
	}
	

}
