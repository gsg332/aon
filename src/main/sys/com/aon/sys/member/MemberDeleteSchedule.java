package com.aon.sys.member;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aon.sys.schedule.ISchedule;
import com.querydsl.core.QueryResults;

@Service
public class MemberDeleteSchedule implements ISchedule {
	
	@Autowired
	MemberQuery query;
	
	@Autowired
	IMemberRepository repository;
	
	/**
	 * 회원탈퇴 스케쥴러 상태값 1000 삭제
	 */
	
	@Override
	public void execute(Map<String, String> p) throws Exception {
		QueryResults<Member> server = query.getSchedulerUnFinishMember();
		List<Member> memberList = server.getResults();
		for(Member member : memberList){
			try{
				repository.delete(member.getId());
			}catch(Exception e){
				e.getStackTrace();
				
			}
			
		}
		System.out.println("#####################TEST SCHEDULE EXECUTE DELETE MEMBER #####################");
	}
}
