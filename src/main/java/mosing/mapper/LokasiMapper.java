package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import mosing.model.LokasiModel;

@Mapper
public interface LokasiMapper {

	@Select("select * from lokasi where id_lokasi = #{id_lokasi}")
	@Results(value = { 
	    		@Result(property = "alamat", column = "alamat"), 
	    		@Result(property = "no_telp", column = "no_telp"),
				@Result(property = "nama_lokasi", column = "nama_lokasi"),
				@Result(property = "id_provinsi", column = "id_provinsi"),
				@Result(property = "id_kota", column = "id_kota"),
				@Result(property = "kuota_peng", column = "kuota_peng"),
				@Result(property = "kuota_pendaftar", column = "kuota_pendaftar")})
	LokasiModel selectLokasi(@Param("id_lokasi") int id_lokasi);
	
	@Select("select alamat, no_telp, nama_lokasi, provinsi, kota from lokasi")
	@Results(value = { 
    		@Result(property = "alamat", column = "alamat"), 
    		@Result(property = "no_telp", column = "no_telp"),
			@Result(property = "nama_lokasi", column = "nama_lokasi"),
			@Result(property = "id_provinsi", column = "id_provinsi"),
			@Result(property = "id_kota", column = "id_kota"),
			@Result(property = "kuota_peng", column = "kuota_peng"),
			@Result(property = "kuota_pendaftar", column = "kuota_pendaftar")})
	List<LokasiModel> selectAllLokasi();

	@Insert("insert into lokasi (alamat, no_telp, nama_lokasi, id_provinsi, id_kota, kuota_peng, kuota_pendaftar) values (#{alamat}, #{no_telp}, #{nama_lokasi}, #{id_provinsi}, #{id_kota}, #{kuota_peng}, #{kuota_pendaftar})")
	void addLokasiUjian(LokasiModel lokasi);

	@Update("update lokasi set alamat = #{alamat}, no_telp = #{no_telp}, nama_lokasi = #{nama_lokasi}, id_provinsi = #{id_provinsi}, id_kota = #{id_kota}, kuota_peng = #{kuota_peng}, kuota_pendaftar = #{kuota_pendaftar} where id_lokasi = #{id_lokasi}")
	void updateLokasiUjian(LokasiModel lokasi);

	@Update("update lokasi set flag = 0 where id_lokasi = #{id_lokasi}}")
	void deleteLokasiUjian(LokasiModel lokasi);
}
