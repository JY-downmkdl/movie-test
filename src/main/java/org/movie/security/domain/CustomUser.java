package org.movie.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.movie.domain.MemberVO;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Data;

@Data
public class CustomUser extends User {
	private MemberVO member;
    private static final long serialVersionUID = 1L; 
	public CustomUser(String username, String password,
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	public CustomUser(MemberVO mvo) {
		super(mvo.getUserid(), mvo.getUserpw(), mvo.getAuthList().stream()
				.map(auth-> new SimpleGrantedAuthority(auth.getAuth()))
				.collect(Collectors.toList()));
		this.member = mvo;
	}
}
