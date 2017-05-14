package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Many;

import mosing.model.FakultasModel;
import mosing.model.ProdiTersediaModel;

@Mapper
public interface FakultasMapper {

	@Select("select * from fakultas")
	List<FakultasModel> selectAllFakultas();
	
	@Select("select * from fakultas where id_fakultas = #{id_fakultas}")
		@Results(value = {
				@Result(property="id_fakultas", column="id_fakultas"),
				@Result(property="fakultas", column="fakultas"),
				@Result(property="listProdi", column="id_fakultas",
						javaType=List.class,
						many=@Many(select="selectProdi"))
		})
	FakultasModel selectFakultasDanProdi(int id_fakultas);
	
	@Select("select * from prodi_tersedia join fakultas "
			+ "on fakultas.id_fakultas = prodi_tersedia.id_fakultas "
			+ "where prodi_tersedia.id_fakultas = #{id_fakultas}")
	@Results(value = {
			@Result(property="id_prodi", column="id_prodi"),
			@Result(property="nama_prodi", column="nama_prodi")
	})
	List<ProdiTersediaModel> selectProdi(int id_fakultas);
	

	
}
