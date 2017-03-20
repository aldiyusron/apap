package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Result;

import mosing.model.LokasiModel;

@Mapper
public interface LokasiMapper {

	@Select("select * from lokasi where nama_lokasi = #{nama_lokasi}")
	@Results(value = { 
	    		@Result(property = "alamat", column = "alamat"), 
	    		@Result(property = "no_telp", column = "no_telp"),
				@Result(property = "nama_lokasi", column = "nama_lokasi"),
				@Result(property = "provinsi", column = "provinsi"),
				@Result(property = "kota", column = "kota")})
	LokasiModel selectLokasi(@Param("nama_lokasi") String nama_lokasi);
	
<<<<<<< HEAD
	@Select("select * from lokasi")
=======
	@Select("select alamat, no_telp, nama_lokasi, provinsi, kota from lokasi")
>>>>>>> branch 'master' of https://github.com/propensi2017/a6.git
	@Results(value = { 
    		@Result(property = "alamat", column = "alamat"), 
    		@Result(property = "no_telp", column = "no_telp"),
			@Result(property = "nama_lokasi", column = "nama_lokasi"),
			@Result(property = "provinsi", column = "provinsi"),
			@Result(property = "kota", column = "kota")})
	List<LokasiModel> selectAllLokasi();
}
