package mosing.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import mosing.model.DetailUjianModel;

@Mapper
public interface DetailUjianMapper {
	
	@Select("select * from detail_ujian")
	DetailUjianModel selectDetail(@Param("id_jalur") int id_jalur);
}
