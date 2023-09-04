package org.movie.controller;

import org.movie.domain.MovieDTO;
import org.movie.service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
@PreAuthorize("isAuthenticated()")
public class AdminController {
	@GetMapping("/register_movie")
	public void goRegister() {
		log.info("영화 등록하기");
		
	}
	
	@Setter(onMethod_ = {@Autowired})
	private MovieService movservice;
	
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
		return "redirect:/movies/moviechart";
	}
	
	@PostMapping("/register_movie")
	public String postregister(MovieDTO mto,RedirectAttributes rttr){
		log.info("=============================================");
		log.info("register : " + mto);
		log.info("=============================================");
		movservice.register(mto);
		rttr.addAttribute("result",mto.getMovcode());
		
		return "redirect:/movies/moviechart";
	}
	
}
