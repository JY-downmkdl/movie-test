package org.movie.service;

import java.util.List;

import org.movie.domain.TheaterDTO;
import org.movie.mapper.TheaterMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class TheaterServiceImpl implements TheaterService{
	@Setter(onMethod_ = {@Autowired})
	private TheaterMapper mapper;

	//지역명으로 영화관 찾기
	@Override
	public List<TheaterDTO> readbyadd(String thaddress) {
		log.info("theater 서비스 impl");
		List<TheaterDTO> loctheaters = mapper.readbyadd(thaddress);
		return loctheaters;
	}

	@Override
	public List<TheaterDTO> getList() {
		log.info("서비스 도착");
		List<TheaterDTO> theaterList = mapper.getList();
		return theaterList;
	}

	@Override
	public TheaterDTO readbycode(int thcode) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<TheaterDTO> thsearch(String keyword) {
		return mapper.thsearch(keyword);
	}
	
	

	
}
