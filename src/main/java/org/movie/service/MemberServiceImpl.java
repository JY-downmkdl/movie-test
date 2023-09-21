package org.movie.service;

import org.movie.domain.AuthVO;
import org.movie.domain.MemberVO;
import org.movie.mapper.AuthMapper;
import org.movie.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MemberServiceImpl implements MemberService{
	@Setter(onMethod_ = {@Autowired})
	private MemberMapper m_mapper;
	@Setter(onMethod_ = {@Autowired})
	private AuthMapper a_mapper;
	
	@Setter(onMethod_ = {@Autowired})
	private PasswordEncoder pwdencoder;
	
	@Override
	public void join(MemberVO mvo) {
		mvo.setUserpw(pwdencoder.encode(mvo.getUserpw()));
		m_mapper.insert(mvo);
		AuthVO avo = new AuthVO();
		avo.setUserid(mvo.getUserid());
		avo.setAuth("ROLE_MEMBER");
		a_mapper.insert(avo);
	}

	
	@Override
	public int modify(MemberVO mvo) {
		mvo.setUserpw(pwdencoder.encode(mvo.getUserpw()));
		return m_mapper.modify(mvo);
	}
	
	
	@Override
	public int check(String id) {
		int cnt = m_mapper.idCheck(id);
		log.info("cnt: " + cnt);
		return cnt;
	}

	@Override
	public MemberVO read(String userid) {
		return m_mapper.read(userid);
	}

	
}
