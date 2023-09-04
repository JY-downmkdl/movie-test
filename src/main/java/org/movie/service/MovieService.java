package org.movie.service;

import java.util.List;

import org.movie.domain.MovieDTO;

public interface MovieService {
	//등록 insert
	public void register(MovieDTO board);
	//게시글 1개 조회 select
	public MovieDTO get(int movcode);
	//서치용
	public List<MovieDTO> serchList(String movname);
	//수정하기 
	public boolean modify(MovieDTO board);
	//삭제하기
	public boolean remove(Long movcode);
	//게시글 목록 조회 
	public List<MovieDTO> getList();
}
