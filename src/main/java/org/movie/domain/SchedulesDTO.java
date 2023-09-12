package org.movie.domain;

import lombok.Data;

@Data
public class SchedulesDTO {
	private String schall; 
	private String schtime; 
	private int schthcode; 
	private int schmovcode;
	
	private String movname;

	private int seatcount;
	private String seatlist;
	
}
