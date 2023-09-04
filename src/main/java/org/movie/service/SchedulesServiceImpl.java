package org.movie.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.movie.domain.SchedulesDTO;
import org.movie.mapper.SchedulesMapper;
import org.movie.mapper.TheaterMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class SchedulesServiceImpl implements SchedulesService {
	@Setter(onMethod_ = {@Autowired})
	private SchedulesMapper mapper;
	
	@Override
	public List<SchedulesDTO> readbythcode(String thcode) {
		List<SchedulesDTO> list = mapper.readbythcode(thcode);
		return list;
	}

	@Override
	public List<SchedulesDTO> readbycodes(String schmovcode,String schthcode) {
		log.info("여기는 스케쥴 서비스");
		List<SchedulesDTO> list = mapper.readbycodes(schmovcode, schthcode);
		return list;
	}

	@Override
	public List<SchedulesDTO> readbytimes(String schmovcode, String schthcode, String schtime) {
		log.info("여기는 스케쥴 서비스");
		List<SchedulesDTO> list = mapper.readbytimes(schmovcode, schthcode, schtime);
		return list;
	}
	
	
	
}
