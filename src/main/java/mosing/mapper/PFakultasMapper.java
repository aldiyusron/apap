package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import mosing.model.FakultasModel;

@Mapper
public interface PFakultasMapper {

	@Select("SELECT * FROM FAKULTAS")
	List<FakultasModel> selectAllFakultas();
}
