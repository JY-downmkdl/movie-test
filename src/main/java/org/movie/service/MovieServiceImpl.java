package org.movie.service;

import java.util.List;

import org.movie.domain.MovieDTO;
import org.movie.mapper.MovieMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Log4j
@Service
@AllArgsConstructor
public class MovieServiceImpl implements MovieService {

	@Setter(onMethod_= {@Autowired})
	private MovieMapper moviemapper;
	@Override
	public void register(MovieDTO mto) {
		moviemapper.insert(mto);
	}

	@Override
	public MovieDTO get(int movcode) {
		MovieDTO gvo = moviemapper.read(movcode);
		return gvo;
	}


	@Override
	public boolean modify(MovieDTO mto) {
		return moviemapper.update(mto) == 1;
	}

	@Override
	public boolean remove(Long movcode) {
		return moviemapper.delete(movcode) == 1;
	}
	

	@Override
	public List<MovieDTO> getList() {
		List<MovieDTO> movieList = moviemapper.getList();
		return movieList;
	}
	@Override
	public List<MovieDTO> getadList() {
		List<MovieDTO> movieList = moviemapper.getadList();
		return movieList ;
	}

	@Override
	public List<MovieDTO> serchList(String movname) {
		return moviemapper.movsearch(movname);
	}

	@Override
	public boolean swthstate(String movcode, int thstates) {
		return moviemapper.updatestate(movcode, thstates) == 1;
	}
	
	
}
