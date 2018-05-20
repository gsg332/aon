package com.aon.sys.member;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.MissingResourceException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.aon.doc.BaseObject;
import com.aon.lib.event.EventPublisher;
import com.aon.lib.security.SH256Cipher;
import com.aon.lib.tree.Node;
import com.aon.module.cyberaccount.CyberAccount;
import com.aon.sys.member.Member.Category;
import com.aon.sys.member.MemberException.BeforePasswordException;
import com.aon.sys.member.confirm.Confirm;
import com.aon.sys.member.confirm.IConfirmRepository;
import com.aon.sys.upload.Upload;
import com.aon.sys.upload.UploadManager;
import com.aon.sys.usr.UserPermission;
import com.aon.sys.usr.UserService;
import com.google.common.collect.Lists;
import com.google.i18n.phonenumbers.PhoneNumberUtil;
import com.querydsl.core.QueryResults;
import com.querydsl.core.Tuple;

@Service
public class MemberService {

	@Autowired
	private IMemberRepository repository;

	@Autowired
	IConfirmRepository confirmRepository;

	@Autowired
	private UploadManager manager;

	private UserPermission permission;

	@Autowired
	private MemberQuery query;

	@Autowired
	private EventPublisher publisher;

	public Member addMember(Member member) {
		return null;
	}

	/**
	 * 국가코드 호출 + 전화,휴대폰 국가코드
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<HashMap<String, Object>> getNationList() throws Exception {
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		PhoneNumberUtil phoneUtil = PhoneNumberUtil.getInstance();
		for (Locale locale : Locale.getAvailableLocales()) {
			try{
				if (!locale.getISO3Country().isEmpty()) {
					HashMap<String, Object> map = new HashMap<>();
					map.put("code", locale.getCountry());
					map.put("name", locale.getDisplayCountry(Locale.ENGLISH));
					map.put("phone", phoneUtil.getCountryCodeForRegion(locale.getCountry()));
					list.add(map);
				}
			}catch(MissingResourceException e){
				
			}
		}
		return new ArrayList<HashMap<String, Object>>(new HashSet<HashMap<String, Object>>(list));
	}

	/**
	 * 닉네임중복체크
	 * 
	 * @param nickName
	 * @return
	 */
	public int duplicateNickNameCheck(String nickname, Long memberId) throws Exception {
		return repository.findByNickName(nickname, memberId);
	}

	/**
	 * 이메일 중복체크(ID로 사용)
	 * 
	 * @param email
	 * @return
	 */
	public String duplicateLoginIdCheck(String loginId) throws Exception {
		return repository.findByLoginIdCnt(loginId);
	}

	/**
	 * 유저정보 조회
	 * 
	 * @return
	 * @throws Exception
	 */
	public Member getMemberInfo() throws Exception {
		Member member = repository.findOne(UserService.getMemberId());
		return member;
	}

	/**
	 * 유저정보 조회
	 * 
	 * @return
	 * @throws Exception
	 */
	public Member getMemberInfo(Long id) throws Exception {
		Member member = repository.findOne(id);
		return member;
	}

	/**
	 * 유저정보 수정
	 * 
	 * @param client
	 */
	public Member memberModify(Member server, Member client) throws Exception {

		if (server.getPassword() != client.getPassword() && !("").equals(client.getPassword())) {
			server.setPassword(SH256Cipher.getSHA256(client.getPassword()));
		}
		server.setType(client.getType());
		server.setNickname(client.getNickname());
		server.setLastName(client.getLastName());
		server.setFirstName(client.getFirstName());
		server.setMale(client.isMale());
		server.setCountryCode(client.getCountryCode());
		server.setAddress(client.getAddress());
		server.setPhoneCountryCode(client.getPhoneCountryCode());
		server.setPhoneNumber(client.getPhoneNumber());
		server.setCellPhoneCountryCode(client.getCellPhoneCountryCode());
		server.setCellPhoneNumber(client.getCellPhoneNumber());
		server.setEmail(client.getEmail());
		server.setCompanyName(client.getCompanyName());
		server.setCompanyNumber(client.getCompanyNumber());
		server.setInsertDate(new Date());
		server.setUpdateDate(new Date());
		server.setStatus(BaseObject.REGISTERED_STATUS);
		permission = new UserPermission();
		if (permission.isAdmin()) {
			server.setAdminComment(client.getAdminComment());
		}
		return server;
	}

	/**
	 * 유저 프로필 수정
	 * 
	 * @param client
	 * @param bankClient
	 * @throws Exception
	 */
	public void memberProfileModify(Member server, Member.MemberProfile client, Member member, HttpServletRequest req)
			throws Exception {
		
		Member.MemberProfile serverProfile = server.getMemberProfile();

		if (("true").equals(client.getIsImageChange()) || client.getImage() != null) {
			Upload image = client.getImage();
			serverProfile.setImage(manager.update(image));
		}
		
		serverProfile.setProfileTitle(client.getProfileTitle());
		serverProfile.setOpen(client.isOpen());
		serverProfile.setCareer(client.getCareer());
		serverProfile.setIntroduce(client.getIntroduce());
		
		Iterator<Category> categories = member.getCategories().iterator();
		while (categories.hasNext()) {
			Category category = categories.next();
			if (category.getCategoryId() == 0) {
				categories.remove();
			}
		} 
		List<Category> categoryList = Lists.newArrayList(categories);
		member.getCategories().addAll(categoryList);
		
		updateCategories(server, member);
		// bankaccount 생성
		req.setAttribute("id", server.getId());
		publisher.broadcast(new MemberEvent.Update(req));
	}

	/**
	 * 유저 탈퇴
	 * 
	 * @param client
	 */
	public void deleteMember(Member client) throws Exception {
		Member server = repository.findOne(UserService.getMemberId());
		server.setDropoutReason(client.getDropoutReason());
		server.setStatus(BaseObject.DELETED_APPLY); // 8000 탈퇴회원 -> 스케쥴러가 돌면서 3달
													// 후 9000으로 변경
		server.setDropoutDate(new Date());
	}

	/**
	 * 멤버의 status 코드를 가져옴 ex) 2000(기존회원), 8000(탈퇴대기회원), 9000(탈퇴회원)
	 * 
	 * @param client
	 * @return
	 * @throws Exception
	 */
	public Member emailConfirmUserStatus(Member client) throws Exception {
		Member member = query.emailConfirmUserStatus(client);
		return member;
	}

	/**
	 * 이메일 인증을 요청한 멤버 정보 update
	 * 
	 * @param request
	 * @param client
	 * @return
	 * @throws Exception
	 */
	public void emailConfirmUserUpdate(HttpServletRequest request, Member client) throws Exception {
		Member member = query.emailConfirmUserUpdate(client);
		String joinAuthToken = SH256Cipher.getSHA256(client.getLoginId());

		// event로 전송할 메일 객체를 생성
		HashMap<String, Object> map = new HashMap<>();
		int status = 0;
		;
		map.put("request", request);
		map.put("member", client);
		map.put("rndNum", 0);

		if (member == null) {
			Member.MemberProfile profile = new Member.MemberProfile();
			member = repository.save(client);
			profile.setMember(member);
			member.setMemberProfile(profile);
			if (member.getId() != null) {
				member.setStatus(Member.APPLIED_STATUS);
				status = Member.APPLIED_STATUS; // status 맵핑 신규가입
			}
		} else {
			if (client.getStatus() == Member.DELETED_APPLY || client.getStatus() == Member.DELETED_STATUS) {
				member.setStatus(Member.REAPPLIED_STATUS);
				status = Member.REAPPLIED_STATUS; // status 맵핑 탈퇴회원
			} else {
				status = Member.APPLIED_STATUS; // status 맵핑 가입진행중
			}
		}
		map.put("status", status); // status를 담는다
		map.put("joinAuthToken", joinAuthToken);
		this.emailConfirmCode(client.getLoginId(), joinAuthToken);
		// 메일발송
		publisher.broadcast(new MemberEvent.SendMail(map));
	}

	/**
	 * 인증 암호화 토큰 생성
	 * 
	 * @param loginId
	 * @param joinAuthToken
	 * @throws ParseException
	 */
	public void emailConfirmCode(String loginId, String joinAuthToken) throws Exception {
		Confirm confirm = new Confirm();
		confirm.setConfirmCode(joinAuthToken);
		confirm.setLoginId(loginId);
		confirm.setInsertDate(new Date());
		confirmRepository.deleteByLoginId(loginId);
		confirmRepository.save(confirm);
	}

	/**
	 * 멤버 비밀번호 찾기
	 * 
	 * @param request
	 * @param client
	 * @return
	 * @throws Exception
	 */
	public Member findMemberPassword(HttpServletRequest request, Member client) throws Exception {
		Member server = new Member();
		server = query.findMemberPassword(client);
		if (server != null && server.getStatus() == 2000) {
			int rndNum = (int) (Math.random() * (99999 - 10000 + 1)) + 10000;
			server.setPassword(SH256Cipher.getSHA256(String.valueOf(rndNum)));

			// 메일보내기 위한 객체를 생성
			HashMap<String, Object> map = new HashMap<>();
			map.put("request", request);
			map.put("member", server);
			map.put("status", server.getStatus());
			map.put("rndNum", rndNum);

			publisher.broadcast(new MemberEvent.SendMail(map));
			return server;
		}
		return null;
	}

	/**
	 * 탈퇴회원목록 조회
	 *
	 * @param page
	 * @param search
	 * @return
	 */
	public Map<String, Object> getDropoutList(Pageable page, MemberSearch search) throws Exception {

		QueryResults<Tuple> result = query.getDropoutList(page, search);
		List<Tuple> list = result.getResults();
		List<Member> memberList = new ArrayList<Member>();

		for (Tuple tuple : list) {
			Member member = tuple.get(0, Member.class);
			CyberAccount cyberAccount = tuple.get(1, CyberAccount.class);
			member.setCyberAccount(cyberAccount);
			memberList.add(member);
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", memberList);
		map.put("count", result.getTotal());

		return map;
	}

	/**
	 * 관리자 회원정보 수정
	 *
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public void memberModifyByAdmin(Member member, HttpServletRequest req) throws Exception {

		Member server = repository.loadWithLock(member.getId());
		memberModify(server, member);
		memberProfileModify(server, member.getMemberProfile(), member, req);
	}

	/**
	 * 회원목록 조회
	 *
	 * @param page
	 * @param search
	 * @return
	 */
	public Map<String, Object> getMemberList(Pageable page, MemberSearch search) throws Exception {

		QueryResults<Tuple> result = query.getList(page, search);
		List<Tuple> list = result.getResults();
		List<Member> memberList = new ArrayList<Member>();

		for (Tuple tuple : list) {
			Member member = tuple.get(0, Member.class);
			CyberAccount cyberAccount = tuple.get(1, CyberAccount.class);
			member.setCyberAccount(cyberAccount);
			memberList.add(member);
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", memberList);
		map.put("count", result.getTotal());

		return map;
	}

	/**
	 * 회원테이블의 질문수 컬럼을 1 증가시킨다.
	 */
	public void plusQuestionCount() throws Exception {
		Member member = repository.findOne(UserService.getMemberId());
		member.setQuestionCnt(member.getQuestionCnt() + 1);
	}

	/**
	 * 회원테이블의 질문수 컬럼을 1 차감시킨다.
	 */
	public void minusQuestionCount() throws Exception {
		Member member = repository.findOne(UserService.getMemberId());
		member.setQuestionCnt(member.getQuestionCnt() - 1);
	}

	/**
	 * 회원테이블의 답변수 컬럼을 1 증가시킨다.
	 */
	public void plusAnswerCount() throws Exception {
		Member member = repository.findOne(UserService.getMemberId());
		member.setAnswerCnt(member.getAnswerCnt() + 1);
	}
	
	/**
	 * 카테고리 정보를 update 한다.
	 *
	 * @param server
	 * @param client
	 * @throws Exception
	 */
	private static void updateCategories(Member server, Member client) throws Exception {
		server.setCategories(client.getCategories());
		server.updateFolderLevel();
	}
	
	/**
	 * 회원 카테고리 조회
	 *
	 * @param page
	 * @param search
	 * @return
	 * @throws Exception 
	 */
	public List<Category> getSpecialty() throws Exception {
		List<Category> result = query.getSpecialty(UserService.getMemberId());
		return result;
	}
	
	/**
	 * 회원 카테고리 조회
	 *
	 * @param page
	 * @param search
	 * @return
	 * @throws Exception 
	 */
	public List<Category> getSpecialty(Long memberId) throws Exception {
		List<Category> result = query.getSpecialty(memberId);
		return result;
	}
	
	public void updateCategoriesByListener(Long categoryId, List<Node> l) throws Exception {
		int result = query.updateCategoryLevel(categoryId, l);
	}
	
	/**
	 * categoryId의 분류에 속한 글의 개수를 반환한다.
	 *
	 * @param categoryId
	 * @return
	 * @throws Exception
	 */
	public List<Object> getContentsCount(Long categoryId) throws Exception {
		return query.getContentsCount(categoryId);
	}
	
	/**
	 * 회원의 비밀번호가 맞는지 확인한다.
	 * 
	 * @param request
	 * @param client
	 * @return
	 * @throws Exception
	 */
	public void checkMemberPassword(Member client) throws Exception {
		
		client.setBeforePassword(SH256Cipher.getSHA256(client.getBeforePassword()));
		
		if(query.checkMemberPassword(client) == 0){
			throw new BeforePasswordException();
		}
	}
	
}
