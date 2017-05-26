package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import mosing.model.DaftarPilihanModel;

@Mapper
public interface DaftarPilihanMapper {

	@Select("SELECT * FROM DAFTAR_PILIHAN WHERE no_daftar=#{no_daftar}")
	List<DaftarPilihanModel> selectPilihan(@Param("no_daftar") int no_daftar);
	
	@Select("SELECT * FROM DAFTAR_PILIHAN WHERE no_daftar=#{no_daftar} ")
	DaftarPilihanModel selectPilihan2(@Param("no_daftar") int no_daftar);
}
