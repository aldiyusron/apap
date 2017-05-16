package mosing.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import mosing.model.CalonMahasiswaModel;

@Mapper
public interface CalonMahasiswaMapper {

	@Select("select * from calon_mahasiswa join pendaftar on"
			+ " calon_mahasiswa.no_daftar = pendaftar.no_daftar"
			+ " where calon_mahasiswa.no_daftar=#{no_daftar}")
	CalonMahasiswaModel selectCalon(@Param("no_daftar") int no_daftar);
}
