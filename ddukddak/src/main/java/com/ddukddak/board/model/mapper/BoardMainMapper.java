package com.ddukddak.board.model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardMainMapper {

	List<Map<String, Object>> selectBoardTypeList();

}
