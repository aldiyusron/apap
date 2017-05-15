package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

import mosing.model.FakultasModel;

@Mapper
public interface FakultasMapper {

	@Select("select * from fakultas where id_fakultas = #{id_fakultas}")
	FakultasModel selectFakultas(int id_fakultas);

	@Select("select * from fakultas")
	@Results(value = {
			@Result(property="id_fakultas", column="id_fakultas"),
			@Result(property="fakultas", column="fakultas")
	})
	List<FakultasModel> selectAllFakultas();

}
