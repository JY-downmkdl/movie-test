package org.movie.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MovieDTO {
	private int movcode;
	private String movname;
	private String movdirector;
	private String movgenre;
	private String movgrade;
	private String movrunningtime;
	private String movrelease;
//	private String movposter;
	
	private String fileName;
	private String uploadPath;
	private String fullname;
	
	private int thstates;
	
}
