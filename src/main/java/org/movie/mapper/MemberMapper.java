package org.movie.mapper;

import org.movie.domain.MemberVO;

public interface MemberMapper {
	//회원 정보
	public MemberVO read(String userid);
	
	//중복확인
	public int idCheck(String userId);
	
	//회원 가입
	public void insert(MemberVO mvo);
	
	//회원 젇보 수정
	public int modify(MemberVO mvo);
}
