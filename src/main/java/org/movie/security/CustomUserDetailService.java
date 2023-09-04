package org.movie.security;

import org.movie.domain.MemberVO;
import org.movie.mapper.MemberMapper;
import org.movie.security.domain.CustomUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailService implements UserDetailsService{
	@Setter(onMethod_ = {@Autowired})
	private MemberMapper mapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		//membermapper를 사용하여 memberVO 조회하고
		//먄약 해당하는 memberVO인스턴스가 있으면 UserDetails 타입으로 변환하여 리턴한다.
		MemberVO mvo = mapper.read(username);
		log.info(mvo);
		return mvo == null? null: new CustomUser(mvo);
	}
}
