package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Many;

import mosing.model.FakultasModel;
import mosing.model.ProdiTersediaModel;

@Mapper
public interface FakultasMapper {

	@Select("SELECT * FROM FAKULTAS")
	List<FakultasModel> selectAllFakultas();
	
	@Select("SELECT * FROM FAKULTAS WHERE id_fakultas = #{id_fakultas}")
		@Results(value = {
				@Result(property="id_fakultas", column="id_fakultas"),
				@Result(property="fakultas", column="fakultas"),
				@Result(property="listProdi", column="id_fakultas",
						javaType=List.class,
						many=@Many(select="selectProdi"))
		})
	FakultasModel selectFakultasDanProdi(int id_fakultas);
	
	@Select("SELECT * FROM PRODI_TERSEDIA JOIN FAKULTAS "
			+ "ON FAKULTAS.id_fakultas = PRODI_TERSEDIA.id_fakultas "
			+ "where PRODI_TERSEDIA.id_fakultas = #{id_fakultas}")
	@Results(value = {
			@Result(property="id_prodi", column="id_prodi"),
			@Result(property="nama_prodi", column="nama_prodi")
	})
	List<ProdiTersediaModel> selectProdi(int id_fakultas);
	
	@Select("SELECT * FROM FAKULTAS WHERE id_fakultas = #{id_fakultas}")
	FakultasModel selectFakultas(@Param("id_fakultas") int id_fakultas);
}
