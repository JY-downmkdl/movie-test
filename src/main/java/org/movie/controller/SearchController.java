package org.movie.controller;

import java.util.List;

import org.movie.domain.MovieDTO;
import org.movie.domain.TheaterDTO;
import org.movie.service.MovieService;
import org.movie.service.TheaterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/search/*")
@AllArgsConstructor
public class SearchController {
	@Setter(onMethod_ = {@Autowired})
	private MovieService movservice;
	
	@Setter(onMethod_ = {@Autowired})
	private TheaterService thservice;
	
	@GetMapping("/all")
	public String selectAll(String keyword, Model model) {
		log.info("드렁왔나요?>/????");
		log.info(keyword);
		//영화 제목 검색
		List<MovieDTO> serchmov= movservice.serchList(keyword);
		log.info(serchmov);
		model.addAttribute("movresult", serchmov);
		
		// 극장 검색
		List<TheaterDTO> serchth = thservice.thsearch(keyword);
		log.info(serchth);
		model.addAttribute("thresult", serchth);
		
		return "/searchresult";
	}
}
