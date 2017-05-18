package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import mosing.model.CalonMahasiswaModel;
import mosing.model.DaftarPilihanModel;
import mosing.model.PendaftarModel;

@Mapper
public interface CalonMahasiswaMapper {

//	@Select("select * from calon_mahasiswa join pendaftar on"
//			+ " calon_mahasiswa.no_daftar = pendaftar.no_daftar"
//			+ " where calon_mahasiswa.no_daftar=#{no_daftar}")
//	CalonMahasiswaModel selectCalon2(@Param)
	
	@Select("select * from calon_mahasiswa where no_daftar=#{no_daftar}")
	CalonMahasiswaModel selectCalon(@Param("no_daftar") int no_daftar);
	@Insert("Insert into daftar_pilihan (no_daftar, jenjang, nama_program, id_prodi, pilihan) values "
			+ "(#{no_daftar}, #{jenjang}, #{nama_program}, #{id_prodi}, #{pilihan})")
	void addDaftarPilihan(DaftarPilihanModel daftar);
	@Insert("insert into calon_mahasiswa (no_daftar, npm, id_prodi, id_jalur, jenjang) values "
			+ "(#{no_daftar}, #{npm}, #{id_prodi}, #{id_jalur}, #{jenjang}) ")
	void addCalon(CalonMahasiswaModel calon);
	
	@Select("select * from calon_mahasiswa")
	List<CalonMahasiswaModel> selectAllCalon();
}
