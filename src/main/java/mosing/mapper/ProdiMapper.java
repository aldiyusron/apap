package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

import mosing.model.DaftarPilihanModel;
import mosing.model.ProdiTersediaModel;

@Mapper
public interface ProdiMapper {

	@Select("select * from prodi_tersedia where id_prodi = #{id_prodi})")
	ProdiTersediaModel selectProdi(@Param("id_prodi") int id_prodi);
	
	@Select("select id_prodi, nama_prodi, daya_tampung, nama_fakultas, id_jalur from prodi_tersedia p where id_jalur=#{id_jalur}")
	List<ProdiTersediaModel> selectAllProdi(@Param("id_jalur") int id_jalur);
	
//	@Select("select id_prodi, nama_prodi from jalur_masuk join prodi_tersedia on jalur_masuk.id_jalur = prodi_tersedia.id_jalur where jalur_masuk.id_jalur = #{id_jalur}")
//	@Results(value = {
//			@Result(property="id_prodi", column="id_prodi"),
//			@Result(property="nama_prodi", column="nama_prodi"),
//			@Result(property="daya_tampung", column="daya_tampung"),
//			@Result(property="nama_fakultas", column="nama_fakultas")
//	})
//	List<ProdiTersediaModel> selectAllProdi(@Param("id_jalur") String id_jalur);
	
	@Insert("insert into daftar_pilihan (no_daftar, jenjang, nama_program, id_prodi, pilihan) values "
			+ "(#{no_daftar}, #{jenjang}, #{nama_program}, #{id_prodi}, #{pilihan}")
	void addRencanaStudi(DaftarPilihanModel daftarPilihan);
}
