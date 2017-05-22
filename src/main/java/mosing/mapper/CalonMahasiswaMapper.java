package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import mosing.model.CalonMahasiswaModel;
import mosing.model.DaftarPilihanModel;

@Mapper
public interface CalonMahasiswaMapper {
	@Select("SELECT * FROM CALON_MAHASISWA JOIN PENDAFTAR ON"
			+ " CALON_MAHASISWA.no_daftar = PENDAFTAR.no_daftar"
			+ " WHERE CALON_MAHASISWA.no_daftar=#{no_daftar}")
	CalonMahasiswaModel selectCalon(@Param("no_daftar") int no_daftar);
	
	@Insert("INSERT INTO DAFTAR_PILIHAN (no_daftar, jenjang, nama_program, id_prodi, pilihan) VALUES "
			+ "(#{no_daftar}, #{jenjang}, #{nama_program}, #{id_prodi}, #{pilihan})")
	void addDaftarPilihan(DaftarPilihanModel daftar);
	@Insert("INSERT INTO CALON_MAHASISWA (no_daftar, npm, id_prodi, id_jalur, jenjang) VALUES "
			+ "(#{no_daftar}, #{npm}, #{id_prodi}, #{id_jalur}, #{jenjang}) ")
	void addCalon(CalonMahasiswaModel calon);
	
	@Select("SELECT * FROM CALON_MAHASISWA")
	List<CalonMahasiswaModel> selectAllCalon();
}
