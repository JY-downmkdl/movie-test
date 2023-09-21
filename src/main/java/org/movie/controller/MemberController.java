package org.movie.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.function.Predicate;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletResponse;

import org.movie.domain.MemberVO;
import org.movie.domain.ReservationDTO;
import org.movie.domain.SchedulesDTO;
import org.movie.service.MemberService;
import org.movie.service.ReservationService;
import org.movie.service.SchedulesService;
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
	private MemberService mvservice;
	private SchedulesService schservice;
	
	//회원가입
	@GetMapping("/join")
	public void join() { 
	}
	@PostMapping("/join")
	public String join(MemberVO mvo,RedirectAttributes rttr) {
		log.info("=============================================");
		log.info("register : " + mvo);
		log.info("=============================================");
		mvservice.join(mvo);
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
		String cnt = Integer.toString(mvservice.check(id)) ;
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
		MemberVO mv = mvservice.read(userid);
		//유저 정보
		model.addAttribute("info",mvservice.read(userid));
		
		//유저가 예매한 영화 1개월 내 보여주기
		model.addAttribute("rvlist",rvservice.reserv(userid));
		
	}
	
	//예매 상세보기
	@GetMapping("/reserve")
	public void goReservation(@RequestParam("userid")String userid, Model model) {
		//유저 정보
		model.addAttribute("info",mvservice.read(userid));
		//유저가 예약한 영화 1개월 전까지만 검색
		model.addAttribute("rvlist",rvservice.reserv(userid));
	}
	
	//예매 취소 
	@ResponseBody
	@GetMapping("/cancel")
	public int cancelreservation(@RequestParam("rvcode")String rvcode, @RequestParam("rvmovcode")String rvmovcode,
			@RequestParam("rvthcode")String rvthcode, @RequestParam("rvschall")String rvschall, 
			@RequestParam("rvschtime")String rvschtime, @RequestParam("rvschseats") String rvschseats) {
		log.info("예매취소" + rvcode);
		// 좌석 다시 돌리기
		//좌석 배열에서 삭제할 요소 찾아서 없애기..
		String[] sl = rvschseats.split(",");
		List<String> delseatlist = Arrays.asList(sl); // 취소할 좌석 목록
		 List<SchedulesDTO> sch = schservice.readbytimes(rvmovcode, rvthcode, rvschtime, rvschall);
		 String[] seatlist = sch.get(0).getSeatlist().split(",");
		 List<String> mdseatlist = Arrays.asList(seatlist); //기존 좌석 목록
		 
		 List<String> resultlist = mdseatlist.stream()
				        .filter(l -> delseatlist.stream().noneMatch(Predicate.isEqual(l)))
				        .collect(Collectors.toList()); // 수정할 좌석
		 
		 log.info(resultlist);
		 
		//새로 만든 좌석배열을 update, 좌석 길이 만큼을 count에 update
		 SchedulesDTO sto = new SchedulesDTO();
		 sto.setSchmovcode(Integer.parseInt(rvmovcode));
		 sto.setSchthcode(Integer.parseInt(rvthcode));
		 sto.setSchtime(rvschtime);
		 sto.setSeatcount(-delseatlist.size());
		 sto.setSeatlist(String.join(",", resultlist)+",");
		 sto.setSchall(rvschall);
		 
		 log.info("sto : " +sto);
		 
		 boolean result1 = rvservice.cancelrv(rvcode); //예매 내역 삭제
		 int result2 = schservice.update(sto); // 스케쥴 테이블 업데이트
		 
		if(result1 && result2 ==1) {
			return 1;
		}
		else {
			return 0;
		}
	}
	
	//회원정보
	@GetMapping("/myinfo")
	public void userinfo(@RequestParam("userid")String userid, Model model) {
		model.addAttribute("list",mvservice.read(userid));
	}
	
	//회원정보 수정
	@PostMapping("/update")
	public void update(MemberVO mvo, HttpServletResponse response) throws IOException{
		log.info("업데이트 mvo : " + mvo);
		int result = mvservice.modify(mvo);
		if(result == 1) {
			PrintWriter write = response.getWriter();
			response.setContentType("text/html; charset=UTF-8");
			String script= "<script>alert('수정되었습니다.');"
					+ "location.href='/member/myinfo?userid="+mvo.getUserid()+"';</script>";
			write.print(script);
			write.close();
		}
		else {
			PrintWriter write = response.getWriter();
			response.setContentType("text/html; charset=UTF-8");
			String script= "<script>alert('수정에 실패하였습니다 다시 시도해주세요');"
					+ "location.href='/member/myinfo?userid="+mvo.getUserid()+"';</script>";
			write.print(script);
			write.close();
		}
	}
	
	
	//나의 문의내역
	@GetMapping("/myqna")
	public void goMyqna(Model model) {
		log.info("문의내역 이동");
	}

}