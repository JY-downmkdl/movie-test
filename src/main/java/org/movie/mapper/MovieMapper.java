package org.movie.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.movie.domain.MovieDTO;

public interface MovieMapper {
	//추상메소드
	public List<MovieDTO> getList();
	
	//추상메소드 - 어드민
	public List<MovieDTO> getadList();
	
	//create --> insert처리
	public void insert(MovieDTO mvo);
	
	//read --> select처리
	public MovieDTO read(int movcode);
	
	//서치용
	public List<MovieDTO> movsearch(String keyword);
	
	//delete --> delete처리
	public int delete(Long movcode);
	
	//update --> update처리
	public int update(MovieDTO board);
	
	// 상영전환
	public int updatestate(@Param("movcode")String movcode, @Param("thstates") int thstates);
}
