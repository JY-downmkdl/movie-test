package org.movie.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;
import java.util.function.Predicate;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletResponse;

import org.movie.domain.MovieDTO;
import org.movie.domain.ReservationDTO;
import org.movie.domain.SchedulesDTO;
import org.movie.service.MovieService;
import org.movie.service.ReservationService;
import org.movie.service.SchedulesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import oracle.net.aso.l;

@Controller
@Log4j
@RequestMapping("/admin/*")
@PreAuthorize("isAuthenticated()")
public class AdminController {
	@Setter(onMethod_ = {@Autowired})
	private MovieService movservice;
	@Setter(onMethod_ = {@Autowired})
	private SchedulesService schservice;
	
	@GetMapping("/moviechart")
	public String goChart(Model model) {
		model.addAttribute("list", movservice.getadList());
		return "/movies/moviechart";
	}
	
	@GetMapping("/register_movie")
	public void goRegister() {
		log.info("영화 등록하기");
	}
	
	@GetMapping("/modify_movie")
	public void goModify(int movcode, Model model) {
		model.addAttribute("board", movservice.get(movcode));
	}
	@PostMapping("/modify_movie")
	public String postmodify(MovieDTO mto) {
		log.info("수정하기!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		log.info("======================수정========================");
		log.info(mto);
		log.info("======================수정========================");
		movservice.modify(mto);
		log.info("실행완");
		return "redirect:/admin/moviechart";
	}
	
	@PostMapping("/register_movie")
	public String postregister(MovieDTO mto,RedirectAttributes rttr){
		log.info("=============================================");
		log.info("register : " + mto);
		log.info("=============================================");
		movservice.register(mto);
		rttr.addAttribute("result",mto.getMovcode());
		
		return "redirect:/admin/moviechart";
	}
	
	
	@GetMapping("/thstateON")
	public String setThstateON(@RequestParam("movcode")String movcode) {
		log.info("상태 상영중으로 전환");
		int thstates = 1;
		movservice.swthstate(movcode, thstates);
		return "redirect:/admin/moviechart";
	}
	@GetMapping("/thstateOFF")
	public String setThstateOFF(@RequestParam("movcode")String movcode) {
		log.info("상태 상영전으로 전환");
		int thstates = 0;
		movservice.swthstate(movcode, thstates);
		return "redirect:/admin/moviechart";
	}
	
	
	
	@Setter(onMethod_ = {@Autowired})
	private ReservationService rvservice;
	@GetMapping("/tickets")
	public void reservations (Model model) {
		model.addAttribute("rvlist",rvservice.reserv(""));
	}
	
	//예매 취소 
	@ResponseBody
	@PostMapping("/cancel")
	public int cancelreservation(@RequestBody List<ReservationDTO> rto, HttpServletResponse response) throws IOException {
		log.info("오긴하니..? " + rto);
		// 좌석 다시 돌리기
		//좌석 배열에서 삭제할 요소 찾아서 없애기..
		int result = 0;
		for(ReservationDTO s : rto) {
			boolean result1 = false;
			int result2 = 0;
			log.info("에러갈피 ---------------------------- " + s);
			String[] sl = s.getRvschseats().split(",");
			List<String> delseatlist = Arrays.asList(sl); // 취소할 좌석 목록
			log.info("뭐가 부적합한데 :" + String.valueOf(s.getRvmovcode()) +","+ String.valueOf(s.getRvthcode()) +","+  s.getRvschtime() +","+  s.getRvschall());
			List<SchedulesDTO> sch = schservice.readbytimes(
					String.valueOf(s.getRvmovcode()), String.valueOf(s.getRvthcode()), s.getRvschtime(), s.getRvschall());
			log.info("sch : " + sch );
			String[] seatlist = sch.get(0).getSeatlist().split(",");
			List<String> mdseatlist = Arrays.asList(seatlist); //기존 좌석 목록
			log.info("기존좌석몰곡 : " + mdseatlist);
			
			List<String> resultlist = mdseatlist.stream()
					.filter(l -> delseatlist.stream().noneMatch(Predicate.isEqual(l)))
					.collect(Collectors.toList()); // 수정할 좌석
			
			log.info("수정 좌석 목록 :  " + resultlist);
			
			//새로 만든 좌석배열을 update, 좌석 길이 만큼을 count에 update
			SchedulesDTO sto = new SchedulesDTO();
			sto.setSchmovcode(s.getRvmovcode());
			sto.setSchthcode(s.getRvthcode());
			sto.setSchtime(s.getRvschtime());
			sto.setSeatcount(-delseatlist.size());
			sto.setSeatlist(String.join(",", resultlist)+",");
			sto.setSchall(s.getRvschall());
			
			log.info("sto : " +sto);
			
			result1 = rvservice.cancelrv(s.getRvcode()); //예매 내역 삭제
			result2 = schservice.update(sto); // 스케쥴 테이블 업데이트
			
			log.info("결과 : "+ result1 +","+ result2);
			
			if(result1 && result2 ==1) {
				result = 1;
			}
			else {
				result = 0;
				break;
			}
		}
		return result;
	}
	
	
}
