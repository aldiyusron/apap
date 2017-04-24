package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Result;

import mosing.model.JalurMasukModel;

@Mapper
public interface JalurMasukMapper {
	
	@Update("update jalur_masuk set flag_aktif=0 where id_jalur=#{id_jalur}")
	void deleteJalurMasuk(JalurMasukModel jalurMasuk);
	
	@Select("select * from Jalur_masuk where id_jalur=#{id_jalur}")
	JalurMasukModel selectJalurMasuk(int id_jalur);
	
	@Select("select * from jalur_masuk where flag_aktif=1")
	@Results(value = { 
    		@Result(property = "nama", column = "nama"), 
    		@Result(property = "tanggal_buka", column = "tanggal_buka"),
			@Result(property = "tanggal_tutup", column = "tanggal_tutup"),
			@Result(property = "status", column = "status"),
			@Result(property = "nama_jenjang", column = "nama_jenjang"),
			@Result(property = "nama_program", column = "nama_program"),
			@Result(property = "persyaratan", column = "persyaratan")})
	List<JalurMasukModel> selectAllJalurMasuk();
}


