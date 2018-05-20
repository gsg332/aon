package com.aon.sys.member;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.aon.doc.IBaseRepository;

@Repository
public  interface IMemberRepository extends IBaseRepository<Member, Long>{
	
	//nativeSQL 사용 방법
	@Query(value = "SELECT COUNT(*) FROM hr_member WHERE loginid = :loginId", nativeQuery = true)
	public String findByLoginIdCnt(@Param("loginId")String loginId);
	
	//jpql사용방법
	@Query(value = "select count(h.nickname) from Member h where h.nickname = ?1 and h.id != ?2")
	public int findByNickName(String nickName, Long memberId);

	@Query(value = "select count(h.email) from Member h where h.email = ?1")
	public String findByEmail(String email);
	
	public Member findByLoginId(String loginId);	
}

