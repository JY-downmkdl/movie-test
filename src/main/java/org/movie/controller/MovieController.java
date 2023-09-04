package org.movie.controller;

import java.util.List;

import org.movie.domain.MovieDTO;
import org.movie.service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/movies/*")
public class MovieController {
	@Setter(onMethod_ = {@Autowired})
	private MovieService movservice;
	
	@GetMapping("/moviechart")
	public void goChart(Model model) {
		model.addAttribute("list", movservice.getList());
	}
	@GetMapping("/detail-view")
	public void goDetail(int movcode, Model model) {
		log.info("영화 상세정보");
		model.addAttribute("board", movservice.get(movcode));
	}
	
	//특정한 게시글 번호의 첨부파일과 관련된 데이터를 json으로 반환하는 메소드
		@GetMapping(value="/getAttachList", 
				produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
		@ResponseBody
		public ResponseEntity<MovieDTO> getAttachList(int movcode){
			return new ResponseEntity<>(movservice.get(movcode), HttpStatus.OK);
		}
}
