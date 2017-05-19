package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import mosing.model.KotaModel;

@Mapper
public interface KotaMapper {
		
	@Select("SELECT id_kota, nama_kota FROM KOTA WHERE id_provinsi = #{id_provinsi}")
	List<KotaModel> selectAllKota(@Param("id_provinsi") int id_provinsi);
	
	@Select("SELECT * FROM KOTA WHERE id_kota = #{id_kota}")
	KotaModel selectKota(int id_kota);

	@Select("SELECT * FROM KOTA")
	List<KotaModel> selectKotaIndo();
}
