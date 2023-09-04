package org.movie.domain;

import lombok.Data;

@Data
public class TheaterDTO {
	private int thcode;
	private String thname;
	private String thaddress;
	
	private int count;
}
