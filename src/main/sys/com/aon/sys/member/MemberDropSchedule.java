package com.aon.sys.member;

import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aon.sys.schedule.ISchedule;
import com.querydsl.core.QueryResults;

@Service
public class MemberDropSchedule implements ISchedule {

	@Autowired
	MemberQuery query;

	@Autowired
	IMemberRepository repository;

	/**
	 * 회원탈퇴 스케쥴러 상태값 8000 -> 9000
	 */

	@Override
	public void execute(Map<String, String> p) throws Exception {
		QueryResults<Member> server = query.getSchedulerDropoutInfo();
		List<Member> memberList = server.getResults();
		Calendar cal = Calendar.getInstance();

		for (Member member : memberList) {
			Member.MemberProfile profile = member.getMemberProfile();
			cal.setTime(member.getDropoutDate());
			boolean result = dateTimediff(cal.getTimeInMillis());
			if (result == true) {
				try {
					member.setType(null);
					member.setNickname(null);
					member.setPassword(null);
					member.setFirstName(null);
					member.setLastName(null);
					member.setCountryCode(null);
					member.setAddress(null);
					member.setPhoneCountryCode(null);
					member.setPhoneNumber(null);
					member.setCellPhoneCountryCode(null);
					member.setCellPhoneNumber(null);
					member.setSms(false);
					member.setMale(false);
					member.setEmail(null);
					member.setStatus(Member.DELETED_STATUS);
					member.setCompanyName(null);
					member.setCompanyNumber(null);
					profile.setCareer(null);
					profile.setIntroduce(null);
					profile.setOpen(false);
					profile.setProfileTitle(null);
					repository.save(member);
				} catch (Exception e) {
					e.printStackTrace();
					new MemberException.MemberDropScheduleException();
					throw e;
				}
			}
		}
		System.out.println("#####################TEST SCHEDULE EXECUTE DROP MEMBER #####################");
	}
	
	/**
	 * 현재날짜와 탈퇴신청 날짜를 비교
	 * 
	 * @param dropDate
	 * @return
	 * @throws ParseException
	 */
	public static boolean dateTimediff(Long dropDate) throws ParseException {

		boolean result = false;
		Date now = new Date();
		Calendar cal1 = Calendar.getInstance();
		cal1.setTime(now);
		long diffMillis = cal1.getTimeInMillis() - dropDate;
		int diff = (int) (diffMillis / (24 * 60 * 60 * 1000));

		if (diff >= 92) {
			result = true;
		}
		return result;
	}
}
