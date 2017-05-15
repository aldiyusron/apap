package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Select;

import mosing.model.LPTerdahuluModel;

@Mapper
public interface LPTerdahuluMapper {

	@Select("select * from lembaga_pendidikan_terakhir")
	@Results(value = { @Result(property = "nama_lembaga", column = "nama_lembaga"),
			@Result(property = "nama_provinsi", column = "nama_provinsi"),
			@Result(property = "nama_kota", column = "nama_kota") })
	List<LPTerdahuluModel> selectAllLPT();

}
