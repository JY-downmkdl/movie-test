package org.movie.service;

import java.util.List;

import org.movie.domain.ReservationDTO;

public interface ReservationService {
	public int reservation(ReservationDTO rto);
	
	//좌석 업뎃
	public int reservation2(ReservationDTO rto);
	
	//예매내역 확인
	public List<ReservationDTO> reserv(String id);
}
