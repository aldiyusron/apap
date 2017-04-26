package mosing.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import mosing.model.DetailUjianModel;

@Mapper
public interface DetailUjianMapper {

	@Select("select j.nama_jenjang, waktu_ujian, tanggal_ujian from detail_ujian d, jalur_masuk j where d.id_jalur=j.id_jalur and d.id_jalur = #{id_jalur}")
	DetailUjianModel selectDetail(@Param("id_jalur") int id_jalur);
	
//	@Select("select waktu_ujian, tanggal_ujian from detail_ujian where id_jalur = #{id_jalur}")
//	DetailUjianModel selectDetailS1(int id_jalur);
//	
//	@Select("select waktu_ujian, tanggal_ujian from detail_ujian where id_jalur= #{id_jalur}")
//	DetailUjianModel selectDetailPascasarjana(int id_jalur);
}
