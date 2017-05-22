package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import mosing.model.DaftarPilihanModel;
import mosing.model.ProdiTersediaModel;

@Mapper
public interface ProdiMapper {

	@Select("SELECT * FROM PRODI_TERSEDIA WHERE id_prodi = #{id_prodi}")
	ProdiTersediaModel selectProdi(@Param("id_prodi") int id_prodi);
	
	@Select("SELECT * FROM PRODI_TERSEDIA p WHERE id_jalur=#{id_jalur}")
	List<ProdiTersediaModel> selectAllProdi(@Param("id_jalur") int id_jalur);
	
	@Insert("INSERT INTO DAFTAR_PILIHAN (no_daftar, jenjang, nama_program, id_prodi, pilihan) VALUES "
			+ "(#{no_daftar}, #{jenjang}, #{nama_program}, #{id_prodi}, #{pilihan}")
	void addRencanaStudi(DaftarPilihanModel daftarPilihan);
	
	@Select("SELECT p.* FROM PRODI_TERSEDIA p WHERE id_fakultas=#{id_fakultas}")
	List<ProdiTersediaModel> selectAllProdiFak(@Param("id_fakultas") int id_fakultas);
	
	@Select("SELECT p.* FROM PRODI_TERSEDIA p")
	List<ProdiTersediaModel> selectAllProdiTersedia();
}
