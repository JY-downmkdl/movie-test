package org.movie.service;

import org.movie.domain.MemberVO;

public interface MemberService {
	public void join(MemberVO mvo);
	public int check(String userid);
	
	//회원정보
	public MemberVO read(String userid);
	
	//회원정보 수정
	public int modify(MemberVO mvo);
}
