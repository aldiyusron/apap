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

	@Select("SELECT * FROM PRODI_TERSEDIA WHERE id_prodi = #{id_prodi}")
	@Results(value = { 
    		@Result(property = "nama_prodi", column = "nama_prodi"), 
    		@Result(property = "daya_tampung", column = "daya_tampung"),
			@Result(property = "id_fakultas", column = "id_fakultas")})
	ProdiTersediaModel selectProdi(@Param("id_prodi") int id_prodi);
	
	@Select("SELECT id_prodi, nama_prodi, daya_tampung, id_fakultas, id_jalur FROM PRODI_TERSEDIA p WHERE id_jalur=#{id_jalur}")
	List<ProdiTersediaModel> selectAllProdi(@Param("id_jalur") int id_jalur);
	
	@Insert("INSERT INTO PRODI_TERSEDIA (nama_prodi, daya_tampung, id_fakultas, id_jalur) VALUES (#{nama_prodi}, #{daya_tampung}, #{id_fakultas}, #{id_jalur})")
	void addProdi(ProdiTersediaModel prodi);
	
	@Update("UPDATE PRODI_TERSEDIA SET nama_prodi = #{nama_prodi}, daya_tampung = #{daya_tampung}, id_fakultas = #{id_fakultas}, id_jalur = #{id_jalur} WHERE id_prodi=#{id_prodi}")
	void updateProdi(ProdiTersediaModel prodi);
	
//	@Update("update prodi_tersedia set flag_aktif = 0 where id_prodi = #{id_prodi}")
//	void deleteProdi(ProdiTersediaModel prodi);
}
