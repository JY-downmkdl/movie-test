package org.movie.service;

import java.util.List;

import org.movie.domain.ReservationDTO;
import org.movie.domain.SchedulesDTO;

public interface SchedulesService {
	public List<SchedulesDTO> readbythcode(String thcode);
	public List<SchedulesDTO> readbycodes(String movcode, String thcode);
	public List<SchedulesDTO> readbytimes(String movcode, String thcode, String schtime, String schall);
	
	//업뎃
	public int update(SchedulesDTO sto);
	
}
