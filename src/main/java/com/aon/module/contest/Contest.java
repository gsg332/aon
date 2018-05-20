package com.aon.module.contest;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.springframework.data.mongodb.core.mapping.Field;

import com.aon.doc.BaseDoc;
import com.aon.doc.BaseJsonView;
import com.aon.doc.category.BaseCategory;
import com.aon.doc.category.ICategorizable;
import com.aon.doc.file.BaseAttachment;
import com.aon.doc.file.IAttachable;
import com.aon.sys.usr.User;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.annotations.QueryEntity;

@QueryEntity
public class Contest extends BaseDoc implements IAttachable<Contest.Attachment>, ICategorizable<Contest.Category> {

	private static final long serialVersionUID = -8021702819783009515L;

	// 공모 취소 상태
	public static final int CANCEL_STATUS = 4000;

	// 공모 취소신청중 상태
	public static final int CANCEL_READY_STATUS = 4100;
	
	// 공모 기간만료 상태
	public static final int EXPIRED_STATUS = 4200;

	// 공모 등록 상태
	// BaseObject 클래스에 선언된 REGISTERED_STATUS 값을 사용한다.

	// 공모 경고 상태
	public static final int WARNING_STATUS = 1000;

	// 공모 완료 상태
	public static final int COMPLETE_STATUS = 3000;

	@JsonView(BaseJsonView.Summary.class)
	private Long answerGroupId;

	@JsonView(BaseJsonView.Summary.class)
	@Field("content-mongo")
	private String content;

	@JsonView(BaseJsonView.Summary.class)
	private long point;

	@JsonView(BaseJsonView.Summary.class)
	private int gradePoint;

	@JsonView(BaseJsonView.Summary.class)
	private String cancelReason;

	@JsonView(BaseJsonView.Summary.class)
	private boolean choose;

	@JsonView(BaseJsonView.Summary.class)
	private boolean read;

	@JsonView(BaseJsonView.Summary.class)
	private boolean favorite;

	@JsonView(BaseJsonView.Summary.class)
	private Date expireDate;

	@JsonView(BaseJsonView.Summary.class)
	private User adminUser;

	@JsonView(BaseJsonView.Detail.class)
	private List<Attachment> attachments;

	@JsonView(BaseJsonView.Summary.class)
	private List<Category> categories;
	
	@JsonView(BaseJsonView.Detail.class)
	private List<Points> points;

	@JsonView(BaseJsonView.Summary.class)
	private String fileExt;

	@JsonView(BaseJsonView.Summary.class)
	@Field("status-mongo")
	private int status;

	@JsonView(BaseJsonView.Summary.class)
	private String loginId;

	@JsonView(BaseJsonView.Summary.class)
	private String nickName;
	
	@JsonView(BaseJsonView.Summary.class)
	private int chooseCount;
	
	@JsonView(BaseJsonView.Summary.class)
	private int shareType;
	
	@JsonView(BaseJsonView.Summary.class)
	private String pointRatio;
		
	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public Long getAnswerGroupId() {
		if (answerGroupId == null) {
			answerGroupId = getId();
			setAnswerGroupId(answerGroupId);
		}
		return answerGroupId;
	}

	public void setAnswerGroupId(Long answerGroupId) {
		this.answerGroupId = answerGroupId;
	}

	public Long getGroupId() {
		Long gid = super.getGroupId();
		if (gid == null) {
			gid = getId();
			setGroupId(gid);
		}
		return gid;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	public String getLoginId() {
		return loginId;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	@Override
	public String getContent() {
		return content;
	}
	@Override
	public void setContent(String content) {
		this.content = content;
	}

	public long getPoint() {
		return point;
	}

	public void setPoint(long point) {
		this.point = point;
	}

	public int getGradePoint() {
		return gradePoint;
	}

	public void setGradePoint(int gradePoint) {
		this.gradePoint = gradePoint;
	}

	public String getCancelReason() {
		return cancelReason;
	}

	public void setCancelReason(String cancelReason) {
		this.cancelReason = cancelReason;
	}

	public boolean isChoose() {
		return choose;
	}

	public void setChoose(boolean choose) {
		this.choose = choose;
	}

	public boolean isRead() {
		return read;
	}

	public void setRead(boolean read) {
		this.read = read;
	}

	public boolean isFavorite() {
		return favorite;
	}

	public void setFavorite(boolean favorite) {
		this.favorite = favorite;
	}

	public Date getExpireDate() {
		return expireDate;
	}

	public void setExpireDate(Date expireDate) {
		this.expireDate = expireDate;
	}

	public User getAdminUser() {
		return adminUser;
	}

	public void setAdminUser(User adminUser) {
		this.adminUser = adminUser;
	}

	@Override
	public List<Attachment> getAttachments() {
		return attachments;
	}

	@Override
	public void setAttachments(List<Attachment> attachments) {
		this.attachments = attachments;
	}
	
	public List<Points> getPoints() {
		return points;
	}

	public void setPoints(List<Points> points) {
		this.points = points;
	}

	@Override
	public void setFileExt(String ext) {
		fileExt = ext;
	}

	@Override
	public String getFileExt() {
		return fileExt;
	}

	@Override
	public void setCategories(List<Category> categories) {
		this.categories = categories;
	}

	@Override
	public List<Category> getCategories() {
		return categories;
	}
	
	public int getChooseCount() {
		return chooseCount;
	}

	public void setChooseCount(int chooseCount) {
		this.chooseCount = chooseCount;
	}

	public int getShareType() {
		return shareType;
	}

	public void setShareType(int shareType) {
		this.shareType = shareType;
	}
	
	public String getPointRatio() {
		return pointRatio;
	}

	public void setPointRatio(String pointRatio) {
		this.pointRatio = pointRatio;
	}
	
	@QueryEntity
	public static class Attachment extends BaseAttachment {
		private static final long serialVersionUID = 1519986692357659556L;
	}

	public static class Category extends BaseCategory {
		private static final long serialVersionUID = 4256061454095761713L;
		
		@JsonView(BaseJsonView.Summary.class)
		private String tag;

		public String getTag() {
			return tag;
		}

		public void setTag(String tag) {
			this.tag = tag;
		}
		
	}
	
	@QueryEntity
	public static class Points extends BaseDoc {
		private static final long serialVersionUID = -3908426134874809579L;
		
		@JsonView(BaseJsonView.Detail.class)
		private Long answerId;
		
		@JsonView(BaseJsonView.Detail.class)
		private int pointRatio;
		
		@JsonView(BaseJsonView.Detail.class)
		private Long point;
		
		public Long getAnswerId() {
			return answerId;
		}

		public void setAnswerId(Long answerId) {
			this.answerId = answerId;
		}
		
		public int getPointRatio() {
			return pointRatio;
		}

		public void setPointRatio(int pointRatio) {
			this.pointRatio = pointRatio;
		}

		public Long getPoint() {
			return point;
		}

		public void setPoint(Long point) {
			this.point = point;
		}
	}

	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
