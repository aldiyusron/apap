package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import mosing.model.CalonMahasiswaModel;
import mosing.model.PendaftarModel;

@Mapper
public interface PUnivMapper {

	static List<CalonMahasiswaModel> selectAllPUniv() {
		// TODO Auto-generated method stub
		return null;
	}

	static void updateCalonMahasiswa(CalonMahasiswaModel pUniv) {
		// TODO Auto-generated method stub
		
	}
	
	@Select("SELECT * FROM PENDAFTAR p JOIN PENYELEKSIAN pe"
			+ " ON p.no_daftar = pe.no_daftar JOIN JALUR_MASUK jm"
			+ " ON pe.id_jalur = jm.id_jalur WHERE jm.id_jalur = #{id_jalur}")
	List<PendaftarModel> selectAllPendaftarSNMPTN(@Param("id_jalur") int id_jalur);
	
	@Select("SELECT * FROM PENDAFTAR p JOIN PENYELEKSIAN pe"
			+ " ON p.no_daftar = pe.no_daftar JOIN JALUR_MASUK jm"
			+ " ON pe.id_jalur = jm.id_jalur WHERE jm.id_jalur = #{id_jalur}")
	List<PendaftarModel> selectAllPendaftarPPKB(@Param("id_jalur") int id_jalur);
}
