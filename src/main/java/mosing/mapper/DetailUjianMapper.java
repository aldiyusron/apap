package mosing.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import mosing.model.DetailUjianModel;

@Mapper
public interface DetailUjianMapper {

	@Select("SELECT j.nama_jenjang, j.waktu_ujian, tanggal_ujian FROM DETAIL_UJIAN d, JALUR_MASUK j WHERE d.id_jalur=j.id_jalur AND d.id_jalur = #{id_jalur}")
	DetailUjianModel selectDetail(@Param("id_jalur") int id_jalur);
	
//	@Select("select waktu_ujian, tanggal_ujian from detail_ujian where id_jalur = #{id_jalur}")
//	DetailUjianModel selectDetailS1(int id_jalur);
//	
//	@Select("select waktu_ujian, tanggal_ujian from detail_ujian where id_jalur= #{id_jalur}")
//	DetailUjianModel selectDetailPascasarjana(int id_jalur);
}
