package org.movie.controller;

import java.util.ArrayList;
import java.util.List;

import org.movie.domain.MovieDTO;
import org.movie.domain.ReservationDTO;
import org.movie.domain.SchedulesDTO;
import org.movie.service.MovieService;
import org.movie.service.ReservationService;
import org.movie.service.SchedulesService;
import org.movie.service.TheaterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/tickets/*")
@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
@AllArgsConstructor
public class TicketController {
	@Setter(onMethod_ = {@Autowired})
	private MovieService movservice;
	@Setter(onMethod_ = {@Autowired})
	private TheaterService thservice;
	@Setter(onMethod_ = {@Autowired})
	private SchedulesService schservice;
	
	
	@GetMapping("/ticket")
	public void goTicket(String movcode, Model model) {
		//만약 영화 정보에서 예매하기눌렀을 때
		if(movcode != "") {
			log.info("잘 검색을 해 보렴");
		}
		log.info("예매 창");
		//그냥 예매하기 눌렀을 때
		model.addAttribute("movList", movservice.getList());
		
		String[] locations = {"울산","서울","경기","인천","강원","충청","대구","부산","경상","제주"};
		model.addAttribute("locations", locations);
		String[] thnames = {thservice.readbyadd("울산").get(0).getThname(), thservice.readbyadd("울산").get(1).getThname()};
		model.addAttribute("thnames", thnames);
		String[] thaddress = {thservice.readbyadd("울산").get(0).getThaddress(),thservice.readbyadd("울산").get(1).getThaddress()};
		model.addAttribute("thaddresses", thaddress);
		int[] thcodes = {thservice.readbyadd("울산").get(0).getThcode(),thservice.readbyadd("울산").get(1).getThcode()};
		model.addAttribute("thcodes", thcodes);
		log.info(thnames[0]+""+thnames[1]);
	}
	
	@GetMapping("/detail-view")
	public @ResponseBody MovieDTO detail(int movcode) {
		log.info(movcode);
		MovieDTO movlist = movservice.get(movcode);
		return movlist;
	}
	
	@GetMapping("/readbycodes")
	public ResponseEntity<List<SchedulesDTO>> readbymovcode(@RequestParam("movcode")String schmovcode, @RequestParam("thcode")String schthcode){
		log.info(schmovcode+", "+schthcode+"여기는 스케쥴 컨트롤러!!!!!!!!!!!");
		List<SchedulesDTO> list = new ArrayList<SchedulesDTO>();
		//schservice.readbymovcode(schmovcode, schthcode)
		list.addAll(schservice.readbycodes(schmovcode, schthcode));
		return new ResponseEntity<List<SchedulesDTO>>(list, HttpStatus.OK);
	}
	
	@GetMapping("/readbytimes")
	public ResponseEntity<List<SchedulesDTO>> readbytimes(@RequestParam("movcode")String schmovcode,
			@RequestParam("thcode")String schthcode, @RequestParam("schtime")String schtime){
		log.info(schmovcode+", "+schthcode+","+schtime+"날짜까지 선택했어");
		List<SchedulesDTO> list = new ArrayList<SchedulesDTO>();
		list.addAll(schservice.readbytimes(schmovcode, schthcode, schtime));
		return new ResponseEntity<List<SchedulesDTO>>(list, HttpStatus.OK);
	}
	
	
	@Setter(onMethod_ = {@Autowired})
	private ReservationService rvservice;
	@PostMapping("/successorder")
	public ResponseEntity<ReservationDTO> Success(ReservationDTO rvdto) {
		log.info("결제 성공--------------------");
		log.info("확인!!!!!!!!!!!!!!!!!!!!!!!!!!!"+rvdto.getRvuserid());
		rvservice.reservation(rvdto);
		rvservice.reservation2(rvdto);
		ReservationDTO result = rvdto;
		log.info("결제 성공--------------------");
		 return new ResponseEntity<ReservationDTO>(result, HttpStatus.OK);
	}
	
	
//	@GetMapping("/lastOrder")
//	public String checkOrder(@RequestParam("merchant_uid") String mu) {
//		log.info("merchant_uid 확인 :"+ mu);
//		return "/member/reserve?userid="+;
//	}
}
