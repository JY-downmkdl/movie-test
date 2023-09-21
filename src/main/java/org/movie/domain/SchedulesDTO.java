package org.movie.domain;

import java.util.List;

import lombok.Data;

@Data
public class SchedulesDTO {
	private String schall; 
	private String schtime; 
	private int schthcode; 
	private int schmovcode;
	private String movname;
	private List<MovieDTO> movList;

	private int seatcount;
	private String seatlist;
	
}
