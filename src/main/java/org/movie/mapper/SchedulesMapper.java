package org.movie.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.movie.domain.ReservationDTO;
import org.movie.domain.SchedulesDTO;

public interface SchedulesMapper {
	//코드로 스케쥴 정보
	public List<SchedulesDTO> readbythcode(String thcode);
	
	//영화관 코드와 영화 코드로 시간 찾기
	public List<SchedulesDTO> readbycodes(@Param("schmovcode")String schmovcode, @Param("schthcode")String schthcode);
	
	//영화관 코드와 영화 코드로 시간 찾기
	public List<SchedulesDTO> readbytimes(
			@Param("schmovcode")String schmovcode,
			@Param("schthcode")String schthcode,
			@Param("schtime")String schtime,
			@Param("schall")String schall
	);
	
	
	//업뎃하기 ( 스케쥴 )
	public int update(SchedulesDTO sto);
	
}
