package mosing.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import mosing.model.ProdiTersediaModel;

@Mapper
public interface ProdiTersediaMapper {
	
	@Select("SELECT * FROM PRODI_TERSEDIA WHERE id_prodi = #{id_prodi}")
	ProdiTersediaModel selectProdi(@Param("id_prodi") int id_prodi);
}
