package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import mosing.model.KotaModel;

@Mapper
public interface KotaMapper {
		
	@Select("select id_kota, nama_kota from kota where id_provinsi = #{id_provinsi}")
	List<KotaModel> selectAllKota(@Param("id_provinsi") int id_provinsi);
	
	@Select("select * from kota where id_kota = #{id_kota}")
	KotaModel selectKota(int id_kota);

	@Select("select * from kota")
	List<KotaModel> selectKotaIndo();
}
