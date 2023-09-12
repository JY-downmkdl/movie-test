package org.movie.controller;

import java.util.List;

import org.movie.domain.MemberVO;
import org.movie.service.MemberService;
import org.movie.service.ReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
import lombok.Setter;
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
	
	@Setter(onMethod_ = {@Autowired})
	private ReservationService rvservice;
	
//	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
//	@GetMapping("/mypage")
//	public void getMypage(String userid, Model model) {
//		if(userid == "") {
//			return;
//		}
//		log.info(userid);
//		MemberVO mv = service.read(userid);
//		//유저 정보
//		model.addAttribute("info",service.read(userid));
//		
//		//유저가 예매한 영화 1개월 내 보여주기
//		model.addAttribute("rvlist",rvservice.reserv(userid));
//	}
	
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	@GetMapping("/mypage")
	public String getMypage() {
		return "/index";
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	@PostMapping("/mypage")
	public void goMypage(@RequestParam("userid")String userid, Model model) {
		log.info(userid);
		MemberVO mv = service.read(userid);
		//유저 정보
		model.addAttribute("info",service.read(userid));
		
		//유저가 예매한 영화 1개월 내 보여주기
		model.addAttribute("rvlist",rvservice.reserv(userid));
		
	}
	
	//예매 상세보기
	@GetMapping("/reserve")
	public void goReservation(@RequestParam("userid")String userid, Model model) {
		//유저 정보
		model.addAttribute("info",service.read(userid));
		//유저가 예약한 영화 1개월 전까지만 검색
		model.addAttribute("rvlist",rvservice.reserv(userid));
		
	}
	
	//회원정보
	@GetMapping("/userinfo")
	public ResponseEntity<MemberVO> userinfo(String userid) {
		MemberVO list = service.read(userid);
		return new ResponseEntity<MemberVO>(list, HttpStatus.OK);
	}
	
	//나의 문의내역
	@GetMapping("/myqna")
	public void goMyqna(Model model) {
		log.info("문의내역 이동");
	}
}