package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import mosing.model.DetailUjianModel;

@Mapper
public interface DetailUjianMapper {

	@Select("SELECT j.nama_jenjang, j.waktu_ujian, tanggal_ujian FROM DETAIL_UJIAN d, JALUR_MASUK j WHERE d.id_jalur=j.id_jalur AND d.id_jalur = #{id_jalur}")
	DetailUjianModel selectDetail(@Param("id_jalur") int id_jalur);
	
	@Select("SELECT * FROM DETAIL_UJIAN d")
	List<DetailUjianModel> selectAllDetail();
	
	@Insert("INSERT INTO DETAIL_UJIAN (no_daftar, no_ujian, id_jalur,"
			+ "id_lokasi, waktu_ujian) VALUES "
			+ "(#{no_daftar}, #{no_ujian}, #{id_jalur}, "
			+ "#{id_lokasi}, #{waktu_ujian})")
	void addDetail(DetailUjianModel detail);
	
}
