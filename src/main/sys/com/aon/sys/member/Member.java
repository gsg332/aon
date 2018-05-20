package com.aon.sys.member;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;

import org.hibernate.annotations.Type;

import com.aon.doc.BaseDoc;
import com.aon.doc.BaseJsonView;
import com.aon.doc.BaseObject;
import com.aon.doc.category.BaseCategory;
import com.aon.doc.category.ICategorizable;
import com.aon.lib.util.NetworkUtil;
import com.aon.module.bankaccount.BankAccount;
import com.aon.module.cyberaccount.CyberAccount;
import com.aon.sys.upload.Upload;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.annotations.Config;
import com.querydsl.core.annotations.QueryEntity;

@QueryEntity
@Config(defaultVariableName = "mem") // 설정해놓으면 QueryDsl에 이름을 변경하여 사용 가능
public class Member extends BaseDoc implements ICategorizable<Member.Category> {

	private static final long serialVersionUID = 4631733174130787164L;

	@JsonView(BaseJsonView.Summary.class)
	private String type;

	@JsonView(BaseJsonView.Summary.class)
	private String loginId;

	@JsonView(BaseJsonView.Summary.class)
	private String nickname;

	private String beforePassword;

	private String password;

	@JsonView(BaseJsonView.Summary.class)
	private String firstName;

	@JsonView(BaseJsonView.Summary.class)
	private String lastName;

	@JsonView(BaseJsonView.Summary.class)
	private String countryCode;

	@JsonView(BaseJsonView.Summary.class)
	private String address;

	@JsonView(BaseJsonView.Summary.class)
	private String phoneCountryCode;

	@JsonView(BaseJsonView.Summary.class)
	private String phoneNumber;

	@JsonView(BaseJsonView.Summary.class)
	private String cellPhoneCountryCode;

	@JsonView(BaseJsonView.Summary.class)
	private String cellPhoneNumber;

	@JsonView(BaseJsonView.Summary.class)
	@Type(type = "numeric_boolean")
	private boolean sms;

	@JsonView(BaseJsonView.Summary.class)
	@Type(type = "numeric_boolean")
	private boolean male;

	@JsonView(BaseJsonView.Summary.class)
	private String email;

	@JsonView(BaseJsonView.Summary.class)
	private Date dropoutDate;

	@JsonView(BaseJsonView.Summary.class)
	private String dropoutReason;

	@JsonView(BaseJsonView.Summary.class)
	private String adminComment;

	@JsonView(BaseJsonView.Summary.class)
	@Type(type = "numeric_boolean")
	private boolean admin;

	@JsonView(BaseJsonView.Summary.class)
	private String companyName;

	@JsonView(BaseJsonView.Summary.class)
	private String companyNumber;

	@JsonView(BaseJsonView.Summary.class)
	@OneToOne(cascade = CascadeType.ALL, mappedBy = "member")
	private MemberProfile memberProfile;

	@JsonView(BaseJsonView.Summary.class)
	private BankAccount bankAccount;

	@JsonView(BaseJsonView.Summary.class)
	private CyberAccount cyberAccount;

	@JsonView(BaseJsonView.Summary.class)
	private long totalAccessCnt;

	@JsonView(BaseJsonView.Summary.class)
	private Long lastAccessIp;

	@JsonView(BaseJsonView.Summary.class)
	private Date lastAccessDate;

	@JsonView(BaseJsonView.Summary.class)
	private long chooseCount;

	@JsonView(BaseJsonView.Summary.class)
	private long questionCnt;

	@JsonView(BaseJsonView.Summary.class)
	private long answerCnt;

	@JsonView(BaseJsonView.Summary.class)
	private List<Category> categories;

	public List<Category> getCategories() {
		return categories;
	}

	public void setCategories(List<Category> categories) {
		this.categories = categories;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getBeforePassword() {
		return beforePassword;
	}

	public void setBeforePassword(String beforePassword) {
		this.beforePassword = beforePassword;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getCountryCode() {
		return countryCode;
	}

	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhoneCountryCode() {
		return phoneCountryCode;
	}

	public void setPhoneCountryCode(String phoneCountryCode) {
		this.phoneCountryCode = phoneCountryCode;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getCellPhoneCountryCode() {
		return cellPhoneCountryCode;
	}

	public void setCellPhoneCountryCode(String cellPhoneCountryCode) {
		this.cellPhoneCountryCode = cellPhoneCountryCode;
	}

	public String getCellPhoneNumber() {
		return cellPhoneNumber;
	}

	public void setCellPhoneNumber(String cellPhoneNumber) {
		this.cellPhoneNumber = cellPhoneNumber;
	}

	public boolean isSms() {
		return sms;
	}

	public void setSms(boolean sms) {
		this.sms = sms;
	}

	public boolean isMale() {
		return male;
	}

	public void setMale(boolean male) {
		this.male = male;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getDropoutDate() {
		return dropoutDate;
	}

	public void setDropoutDate(Date dropoutDate) {
		this.dropoutDate = dropoutDate;
	}

	public String getDropoutReason() {
		return dropoutReason;
	}

	public void setDropoutReason(String dropoutReason) {
		this.dropoutReason = dropoutReason;
	}

	public String getAdminComment() {
		return adminComment;
	}

	public void setAdminComment(String adminComment) {
		this.adminComment = adminComment;
	}

	public boolean isAdmin() {
		return admin;
	}

	public void setAdmin(boolean admin) {
		this.admin = admin;
	}

	public MemberProfile getMemberProfile() {
		return memberProfile;
	}

	public void setMemberProfile(MemberProfile memberProfile) {
		this.memberProfile = memberProfile;
	}

	public CyberAccount getCyberAccount() {
		return cyberAccount;
	}

	public void setCyberAccount(CyberAccount cyberAccount) {
		this.cyberAccount = cyberAccount;
	}

	public Date getLastAccessDate() {
		return lastAccessDate;
	}

	public long getTotalAccessCnt() {
		return totalAccessCnt;
	}

	public void setTotalAccessCnt(long totalAccessCnt) {
		this.totalAccessCnt = totalAccessCnt;
	}

	public Long getLastAccessIp() {
		return lastAccessIp;
	}

	public void setLastAccessIp(Long lastAccessIp) {
		this.lastAccessIp = lastAccessIp;
	}

	@JsonView(BaseJsonView.Summary.class)
	public String getIpAddress() {
		Long ip = getLastAccessIp();
		if (ip != null) {
			return NetworkUtil.longToStringIp(getLastAccessIp());
		}
		return null;
	}

	public void setLastAccessDate(Date lastAccessDate) {
		this.lastAccessDate = lastAccessDate;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getCompanyNumber() {
		return companyNumber;
	}

	public void setCompanyNumber(String companyNumber) {
		this.companyNumber = companyNumber;
	}

	public BankAccount getBankAccount() {
		return bankAccount;
	}

	public void setBankAccount(BankAccount bankAccount) {
		this.bankAccount = bankAccount;
	}

	public long getChooseCount() {
		return chooseCount;
	}

	public void setChooseCount(long chooseCount) {
		this.chooseCount = chooseCount;
	}

	public long getQuestionCnt() {
		return questionCnt;
	}

	public void setQuestionCnt(long questionCnt) {
		this.questionCnt = questionCnt;
	}

	public long getAnswerCnt() {
		return answerCnt;
	}

	public void setAnswerCnt(long answerCnt) {
		this.answerCnt = answerCnt;
	}

	@QueryEntity
	@Config(defaultVariableName = "memberCategory")
	public static class Category extends BaseCategory {
		private static final long serialVersionUID = 373533315635344825L;
		
		private Long memberId;

		public Long getMemberId() {
			return memberId;
		}

		public void setMemberId(Long memberId) {
			this.memberId = memberId;
		}
	}

	@QueryEntity
	public static class MemberProfile extends BaseDoc {

		private static final long serialVersionUID = 1L;

		@JsonView(BaseJsonView.Summary.class)
		private String profileTitle;

		@JsonView(BaseJsonView.Summary.class)
		@Type(type = "numeric_boolean")
		private boolean open;

		@JsonView(BaseJsonView.Summary.class)
		private String career;

		@JsonView(BaseJsonView.Summary.class)
		private String introduce;

		@JsonView(BaseJsonView.Detail.class)
		private Upload image;

		private String isImageChange = "";

		public String getIsImageChange() {
			return isImageChange;
		}

		public void setIsImageChange(String isImageChange) {
			this.isImageChange = isImageChange;
		}

		@OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
		@JoinColumn(name = "member_id", insertable = false, updatable = false)
		private Member member;

		public Member getMember() {
			return member;
		}

		public void setMember(Member member) {
			this.member = member;
		}

		public String getProfileTitle() {
			return profileTitle;
		}

		public void setProfileTitle(String profileTitle) {
			this.profileTitle = profileTitle;
		}

		public boolean isOpen() {
			return open;
		}

		public void setOpen(boolean open) {
			this.open = open;
		}

		public String getCareer() {
			return career;
		}

		public void setCareer(String career) {
			this.career = career;
		}

		public String getIntroduce() {
			return introduce;
		}

		public void setIntroduce(String introduce) {
			this.introduce = introduce;
		}

		public Upload getImage() {
			return image;
		}

		public void setImage(Upload image) {
			this.image = image;
		}
	}

	@QueryEntity
	@Config(defaultVariableName = "access")
	public static class Access extends BaseObject {

		private static final long serialVersionUID = 4404671086305197590L;

		@JsonView(BaseJsonView.Summary.class)
		private Long accessId;

		@JsonView(BaseJsonView.Summary.class)
		private Long ip;

		@JsonView(BaseJsonView.Summary.class)
		private Date insertDate;

		@JsonView(BaseJsonView.Summary.class)
		private Long memberId;

		public Long getAccessId() {
			return accessId;
		}

		public void setAccessId(Long accessId) {
			this.accessId = accessId;
		}

		public Long getIp() {
			return ip;
		}

		public void setIp(Long ip) {
			this.ip = ip;
		}

		@JsonView(BaseJsonView.Summary.class)
		public String getIpAddress() {
			Long ip = getIp();
			if (ip != null) {
				return NetworkUtil.longToStringIp(getIp());
			}
			return null;
		}

		public Date getInsertDate() {
			return insertDate;
		}

		public void setInsertDate(Date insertDate) {
			this.insertDate = insertDate;
		}

		public Long getMemberId() {
			return memberId;
		}

		public void setMemberId(Long memberId) {
			this.memberId = memberId;
		}
	}
}
