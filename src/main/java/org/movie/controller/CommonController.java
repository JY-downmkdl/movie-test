package org.movie.controller;

import org.movie.service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class CommonController {
	@Setter(onMethod_ = {@Autowired})
	private MovieService movservice;
	
	@GetMapping("/index")
	public void goIndex(Model model) {
		//무비차트용
		model.addAttribute("list", movservice.getList());
	}
	
	@GetMapping("/accessError")
	public void accessDeniend(Authentication auth, Model model) {
		log.info("접근 거부 : "+ auth);
		model.addAttribute("msg", "접근 거부");
	}
	@PostMapping("/logout")
	public String logoutGet() {
		log.info("로그아웃?");
		return "/index";
	}
	
}
