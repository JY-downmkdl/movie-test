package org.movie.mapper;

import org.movie.domain.MemberVO;

public interface MemberMapper {
	//회원 정보
	public MemberVO read(String userid);	
	
	//중복확인
	public int idCheck(String userId);
	
	//회원 가입
	public void insert(MemberVO mvo);
}
