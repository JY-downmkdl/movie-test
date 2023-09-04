package org.movie.service;

import java.util.List;

import org.movie.domain.TheaterDTO;

public interface TheaterService {
	//게시글 목록 조회 
	public List<TheaterDTO> getList();

	public TheaterDTO readbycode(int thcode);
	
	public List<TheaterDTO> thsearch(String keyword);
	
	public List<TheaterDTO> readbyadd(String thcaddress);
	
}
