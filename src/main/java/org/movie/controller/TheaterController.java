package org.movie.controller;

import java.util.ArrayList;
import java.util.List;

import org.movie.domain.SchedulesDTO;
import org.movie.domain.TheaterDTO;
import org.movie.service.TheaterService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/theaters/*")
@AllArgsConstructor
public class TheaterController {
	private TheaterService service;
	
	//전체 조회
	@GetMapping("/location")
	public void goLocation(String thname, Model model) {
		log.info("시에터 컨트롤러");
		log.info(thname+"!!!!!!!!!!!!!!!!");
		log.info("코드 있어요");
		String[] locations = {"울산","서울","경기","인천","강원","충청","대구","부산","경상","제주"};
		model.addAttribute("locations", locations);
		List<TheaterDTO> thlist = new ArrayList<TheaterDTO>();
		thlist.addAll(service.readbyadd(thname));
		model.addAttribute("thlist", thlist);
//		String[] thnames = {service.readbyadd("울산").get(0).getThname(), service.readbyadd("울산").get(1).getThname()};
//		model.addAttribute("thnames", thnames);
//		String[] thaddress = {service.readbyadd("울산").get(0).getThaddress(),service.readbyadd("울산").get(1).getThaddress()};
//		model.addAttribute("thaddresses", thaddress);
//		int[] thcodes = {service.readbyadd("울산").get(0).getThcode(),service.readbyadd("울산").get(1).getThcode()};
//		model.addAttribute("thcodes", thcodes);
		//log.info(thnames[0]+""+thnames[1]);
	}
	@ResponseBody
	@PostMapping("/readbycodeaction")
	public List<TheaterDTO> locaddress(@RequestParam("locaddress")String locaddress) {
		log.info(locaddress);
	
		List<TheaterDTO> list = new ArrayList<TheaterDTO>();
		list.addAll(service.readbyadd(locaddress));
		log.info("아 결과 달라고"+list.get(0));
		return list;
		
	}
	@ResponseBody
	@GetMapping("/readbynameaction")
	public List<TheaterDTO> locname(@RequestParam("locname")String locname) {
		log.info(locname);
		
		List<TheaterDTO> list = new ArrayList<TheaterDTO>();
		list.addAll(service.readbyadd(locname));
		log.info("아 결과 달라고"+list.get(0));
		return list;
		
	}
}
