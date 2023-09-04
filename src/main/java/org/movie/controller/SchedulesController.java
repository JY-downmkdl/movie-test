package org.movie.controller;

import java.util.ArrayList;
import java.util.List;

import org.movie.domain.SchedulesDTO;
import org.movie.domain.TheaterDTO;
import org.movie.service.SchedulesService;
import org.movie.service.TheaterService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/schedules/*")
@AllArgsConstructor
public class SchedulesController {
	private SchedulesService service;
	
	
	// 지역관 a 태그 누르면 이동해는 곳
	@ResponseBody
	@GetMapping("/readbythcode")
	public ResponseEntity<List<SchedulesDTO>> readbythcode(@RequestParam("schthcode")String schthcode){
		List<SchedulesDTO> list = new ArrayList<SchedulesDTO>();
		log.info(schthcode+"여기는 스케쥴 컨트롤러");
		
		list.addAll(service.readbythcode(schthcode));
		
		log.info(list);
		return new ResponseEntity<List<SchedulesDTO>>(list, HttpStatus.OK);
	}
	
	@GetMapping("/readbymovcode")
	public List<SchedulesDTO> readbymovcode(@RequestParam("movcode")String movcode, @RequestParam("thcode")String thcode){
		log.info(thcode+"여기는 스케쥴 컨트롤러");
		
		List<SchedulesDTO> list = new ArrayList<SchedulesDTO>();
		list.addAll(service.readbycodes(movcode, thcode));
		return list;
	}
}
