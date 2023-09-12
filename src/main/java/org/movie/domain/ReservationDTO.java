package org.movie.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class ReservationDTO {
	private String rvcode; 
	private String rvuserid; 
	private int rvmovcode; 
	private String rvmovname; 
	
	private int rvthcode; 
	private String rvthname; 
	private String rvschtime;
	private String rvschall; //관
	
	private int rvcount; // 예약 인원
	private String rvschseats; // 좌석명리스트
	private String rvlist; // 성인 n명 ..
	private int rvprice; // 결제가격
	
	private Date rvtime;
	
	private String paymethod;
	
	// 00 : 00 ~ 00 : 00
	private String rvrunning;
	
	private MovieDTO movList;
}
