package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import mosing.model.DaftarPilihanModel;
import mosing.model.ProdiTersediaModel;

@Mapper
public interface ProdiTersediaMapper {

	@Select("select * from prodi_tersedia where id_prodi = #{id_prodi} and flag_aktif=1")
	@Results(value = { 
    		@Result(property = "nama_prodi", column = "nama_prodi"), 
    		@Result(property = "daya_tampung", column = "daya_tampung"),
			@Result(property = "id_fakultas", column = "id_fakultas")})
	ProdiTersediaModel selectProdi(@Param("id_prodi") int id_prodi);
	
	@Select("select id_prodi, nama_prodi, daya_tampung, id_fakultas, id_jalur from prodi_tersedia p where id_jalur=#{id_jalur} and flag_aktif=1")
	List<ProdiTersediaModel> selectAllProdi(@Param("id_jalur") int id_jalur);
	
	@Insert("insert into prodi_tersedia (nama_prodi, daya_tampung, id_fakultas, id_jalur, flag_aktif) values (#{nama_prodi}, #{daya_tampung}, #{id_fakultas}, #{id_jalur}, 1)")
	void addProdi(ProdiTersediaModel prodi);
	
	@Update("update prodi_tersedia set nama_prodi = #{nama_prodi}, daya_tampung = #{daya_tampung}, id_fakultas = #{id_fakultas}, id_jalur = #{id_jalur} where id_prodi=#{id_prodi} and flag_aktif = 1")
	void updateProdi(ProdiTersediaModel prodi);
	
	@Update("update prodi_tersedia set flag_aktif = 0 where id_prodi = #{id_prodi}")
	void deleteProdi(ProdiTersediaModel prodi);
}
