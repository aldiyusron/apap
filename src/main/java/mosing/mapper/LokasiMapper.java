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

	@Select("SELECT * FROM LOKASI WHERE id_lokasi = #{id_lokasi} AND flag_aktif = 1")
	@Results(value = { 
	    		@Result(property = "alamat", column = "alamat"), 
	    		@Result(property = "no_telp", column = "no_telp"),
				@Result(property = "nama_lokasi", column = "nama_lokasi"),
				@Result(property = "nama_provinsi", column = "nama_provinsi"),
				@Result(property = "nama_kota", column = "nama_kota"),
				@Result(property = "kuota_peng", column = "kuota_peng"),
				@Result(property = "kuota_pendaftar", column = "kuota_pendaftar")})
	LokasiModel selectLokasi(@Param("id_lokasi") int id_lokasi);
	
	@Select("SELECT * FROM LOKASI WHERE flag_aktif = 1")
	List<LokasiModel> selectAllLokasi();

	@Insert("INSERT INTO LOKASI (id_jalur, alamat, no_telp, nama_lokasi, nama_provinsi, nama_kota, kuota_peng, kuota_pendaftar, flag_aktif) VALUES (#{id_jalur}, #{alamat}, #{no_telp}, #{nama_lokasi}, #{nama_provinsi}, #{nama_kota}, #{kuota_peng}, #{kuota_pendaftar}, 1)")
	void addLokasiUjian(LokasiModel lokasi);

	@Update("UPDATE LOKASI SET alamat = #{alamat}, no_telp = #{no_telp}, nama_lokasi = #{nama_lokasi}, nama_provinsi = #{nama_provinsi}, nama_kota = #{nama_kota}, kuota_peng = #{kuota_peng}, kuota_pendaftar = #{kuota_pendaftar} WHERE id_lokasi = #{id_lokasi} AND flag_aktif = 1")
	void updateLokasiUjian(LokasiModel lokasi);

	@Update("UPDATE LOKASI SET flag_aktif = 0 WHERE id_lokasi = #{id_lokasi}")
	void deleteLokasiUjian(LokasiModel lokasi);
	
	@Select("SELECT * FROM LOKASI WHERE id_jalur = #{id_jalur} AND flag_aktif = 1")
	List<LokasiModel> selectLokasiJalur(@Param("id_jalur") int id_jalur);
}
