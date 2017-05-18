package mosing.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import mosing.model.FakultasModel;

@Mapper
public interface FakultasMapper {
	
	@Select("SELECT * FROM FAKULTAS WHERE id_fakultas = #{id_fakultas}")
	FakultasModel selectFakultas(@Param("id_fakultas") int id_fakultas);
}
