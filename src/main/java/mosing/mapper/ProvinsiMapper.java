package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Many;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Select;

import mosing.model.KotaModel;
import mosing.model.ProvinsiModel;

@Mapper
public interface ProvinsiMapper {
	
	@Select("SELECT * FROM PROVINSI WHERE id_provinsi=#{id_provinsi}")
	@Results(value = {
			@Result(property="nama_provinsi", column="nama_provinsi"),
			@Result(property="id_negara", column="id_negara"),
			@Result(property="listKota", column="id_kota",
				javaType=List.class,
				many=@Many(select="selectAllKota"))
	})
	ProvinsiModel selectProvinsiDanKotanya(@Param("id_provinsi") int id_provinsi);
	
	@Select("SELECT id_kota, nama_kota FROM PROVINSI p JOIN KOTA k "
			+ "ON p.id_provinsi=k.id_provinsi "
			+ "WHERE p.id_provinsi=#{id_provinsi}")
	@Results(value = {
			@Result(property="id_kota", column="id_kota"),
			@Result(property="nama_kota", column="nama_kota")
	})
	List<KotaModel> selectAllKota(@Param("id_provinsi") int id_provinsi);
	
	@Select("SELECT * FROM PROVINSI")
	@Results(value = {
			@Result(property="id_provinsi", column="id_provinsi"),
			@Result(property="nama_provinsi", column="nama_provinsi"),
			@Result(property="listKota", column="id_kota",
					javaType=List.class,
					many=@Many(select="selectAllKota"))
		})
	List<ProvinsiModel> selectAllProvinsi();
}
