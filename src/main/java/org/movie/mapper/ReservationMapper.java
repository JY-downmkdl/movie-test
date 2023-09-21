package org.movie.mapper;

import java.util.List;

import org.movie.domain.ReservationDTO;

public interface ReservationMapper {
	//예매하기!!!!
	public int insert(ReservationDTO rto);
	
	//업뎃하기 ( 스케쥴 )
	public int update(ReservationDTO rto);
	
	//예매내역 확인
	public List<ReservationDTO> selectReserv(String rvuserid);
	
	//예매 취소
	public int cancelrv(String rvcode);
}
