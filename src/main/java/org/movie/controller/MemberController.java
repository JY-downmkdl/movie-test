package org.movie.controller;

import org.movie.domain.MemberVO;
import org.movie.service.MemberService;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {
	private MemberService service;
	
	//회원가입
	@GetMapping("/join")
	public void join() { 
	}
	@PostMapping("/join")
	public String join(MemberVO mvo,RedirectAttributes rttr) {
		log.info("=============================================");
		log.info("register : " + mvo);
		log.info("=============================================");
		service.join(mvo);
		rttr.addAttribute("result",mvo.getUserid());
		return "redirect:/index";
	}
	
	//로그인
	@GetMapping("/login")
	public void login() { 
	}
	@PostMapping("/login")
	public void login(String error, String logout, Model model) {
		log.info("에러: "+ error);
		log.info("로그아웃 : " + logout);
		
		// 값이 있을 경우
		if( error != null) {
			model.addAttribute("error", "로그인 오류");
		}
		if(logout != null) {
			model.addAttribute("logout", "로그아웃");
		}
	}
	
	// 아이디 중복확인
	@ResponseBody
	@PostMapping("/IdCheckService")
	public String check(@RequestParam("id")String id) {
		log.info("id : " + id);
		String cnt = Integer.toString(service.check(id)) ;
		log.info(cnt);
		return cnt;
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	@GetMapping("/mypage")
	public void goMypage() {
		log.info("마이페이지를 들어갈수 있는지 없는지");
	}
}
