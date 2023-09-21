package org.movie.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.movie.domain.MovieDTO;
import org.springframework.web.bind.annotation.RequestParam;

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
	//어드민전용 게시글 목록 조회 
	public List<MovieDTO> getadList();
	//어드민 상영전환
	public boolean swthstate(String movcode, int thstates);
}
