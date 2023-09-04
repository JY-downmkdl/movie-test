package org.movie.mapper;

import java.util.List;
import java.util.Map;

import org.movie.domain.TheaterDTO;

public interface TheaterMapper {
	//전체조회
	public List<TheaterDTO> getList();
	
	//영//지역명으로 영화관 정보
	public List<TheaterDTO> readbyadd(String location);
	
	//서치용
	public List<TheaterDTO> thsearch(String keyword);
	
	//코드로 영화관 정보
	public TheaterDTO readbycode(int thcode);
	
	
	
}
