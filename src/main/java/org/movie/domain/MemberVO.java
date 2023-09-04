package org.movie.domain;

import java.util.List;

import org.movie.domain.AuthVO;

import lombok.Data;

@Data
public class MemberVO {
	private String userid;
	private String userpw;
	private String username;
	private String birth;
	private String phone;
	private boolean enabled;
	
	private List<AuthVO> authList;
}
