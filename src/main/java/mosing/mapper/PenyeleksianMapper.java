package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import mosing.model.PenyeleksianModel;

@Mapper
public interface PenyeleksianMapper {

	@Insert("INSERT INTO PENYELEKSIAN (no_daftar, status, id_jalur, status_rekomen, berkas) VALUES (#{no_daftar}, #{status}, #{id_jalur}, 0, #{berkas})")
	void addPenyeleksian(PenyeleksianModel penyeleksian);

	@Select("SELECT * FROM PENYELEKSIAN WHERE id_jalur = #{id_jalur}")
	PenyeleksianModel selectPenyeleksian(@Param("id_jalur") int id_jalur);
	
	@Select("SELECT p.* FROM PENYELEKSIAN p WHERE p.no_daftar = #{no_daftar}")
	PenyeleksianModel selectPenyeleksian2(@Param("no_daftar") int no_daftar);

	@Update("UPDATE PENYELEKSIAN SET berkas=#{berkas} WHERE no_daftar=#{no_daftar}")
	void updateBerkas(@Param("berkas") String berkas, @Param("no_daftar") int no_daftar);
	
	@Select("SELECT * from PENYELEKSIAN")
	List<PenyeleksianModel> selectAllPenyeleksian();
	
	@Delete("DELETE FROM PENYELEKSIAN WHERE no_daftar=#{no_daftar}")
	void deletePenyeleksian(PenyeleksianModel penyeleksian);

	@Update("UPDATE PENYELEKSIAN SET status = 1, status_rekomen = 1 where no_daftar = #{no_daftar}")
	void updateLulus(@Param("no_daftar") int no_daftar);
	
	@Update("UPDATE PENYELEKSIAN SET status_rekomen = 1 where no_daftar = #{no_daftar}")
	void updateRekomen(@Param("no_daftar") int no_daftar);
}
