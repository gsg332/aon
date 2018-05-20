package com.aon.sys.login;

import org.springframework.stereotype.Repository;

import com.aon.doc.IBaseRepository;
import com.aon.sys.member.Member.Access;

@Repository
public interface IAccessRepository extends IBaseRepository<Access, Long> {
}