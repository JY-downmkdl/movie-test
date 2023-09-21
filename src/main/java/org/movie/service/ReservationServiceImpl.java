package org.movie.service;

import java.util.List;

import org.movie.domain.ReservationDTO;
import org.movie.mapper.ReservationMapper;
import org.movie.mapper.SchedulesMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Service
@Log4j
@AllArgsConstructor
public class ReservationServiceImpl implements ReservationService{
	@Setter(onMethod_ = {@Autowired})
	private ReservationMapper mapper;
	
	//결제 후 데베에 정보 넣기
	@Override
	public int reservation(ReservationDTO rto) {
		String[] counts = rto.getRvschseats().split(",");
		rto.setRvcount(counts.length);
		//rto.setRvuserid(rto.getRvuserid().trim());
		return mapper.insert(rto);
		//매퍼 이용해서 테이블에 값 넣기!!
	}

	@Override
	public int reservation2(ReservationDTO rto) {
		String[] counts = rto.getRvschseats().split(",");
		rto.setRvcount(counts.length);
		return mapper.update(rto);
	}

	@Override
	public List<ReservationDTO> reserv(String id) {
		return mapper.selectReserv(id);
	}

	@Override
	public boolean cancelrv(String rvcode) {
		return mapper.cancelrv(rvcode) == 1;
	}
	
	
}
