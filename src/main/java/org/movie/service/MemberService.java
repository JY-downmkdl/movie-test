package org.movie.service;

import org.movie.domain.MemberVO;

public interface MemberService {
	public void join(MemberVO mvo);
	public int check(String userid);
}
