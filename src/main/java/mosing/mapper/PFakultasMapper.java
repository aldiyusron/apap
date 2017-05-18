package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import mosing.model.FakultasModel;

@Mapper
public interface PFakultasMapper {

	@Select("select * from fakultas")
	List<FakultasModel> selectAllFakultas();
}
