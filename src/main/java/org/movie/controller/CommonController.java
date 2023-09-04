package org.movie.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class CommonController {
	@GetMapping("/index")
	public void goIndex() {
		
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
