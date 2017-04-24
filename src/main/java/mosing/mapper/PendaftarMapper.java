package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;

import mosing.model.JalurMasukModel;
import mosing.model.PendaftarModel;

@Mapper
public interface PendaftarMapper {

	@Select("select * from pendaftar where no_id=#{no_id}")
	PendaftarModel selectPendaftar(@Param("no_id") String no_id);

	@Insert("INSERT INTO pendaftar (id_user, no_id, nama_id, "
			+ "nama_ijazah, foto, no_hp, no_telp, nama_negara, kewarganegaraan, alamat_tetap, "
			+ "jenis_id, alamat_sekarang, tgl_lahir, nama_provinsi, nama_kota, jenis_kelamin, "
			+ "nama_lembaga, jurusan, no_daftar) VALUES "
			+ "(#{id_user}, #{no_id}, #{nama_id}, "
			+ "#{nama_ijazah}, #{foto}, #{no_hp}, #{no_telp}, #{nama_negara}, #{kewarganegaraan},"
			+ "#{alamat_tetap}, #{jenis_id}, #{alamat_sekarang}, #{tgl_lahir}, #{nama_provinsi}, "
			+ "#{nama_kota}, #{jenis_kelamin}, #{nama_lembaga}, #{jurusan}, #{no_daftar})")
	void addPendaftar(PendaftarModel pendaftar);
	
	@Select("select p.* from pendaftar p"
			+ " join PENYELEKSIAN on p.no_daftar = penyeleksian.no_daftar"
			+ " WHERE penyeleksian.status=0")
	List<PendaftarModel> selectAllPendaftarTerverifikasi();
	
	@Select("select p.* from pendaftar p"
			+ " join PENYELEKSIAN on p.no_daftar = penyeleksian.no_daftar"
			+ " WHERE penyeleksian.status=0")
	List<PendaftarModel> selectAllPendaftarTakTerverifikasi();
	
	@Select("select nama_id, no_id, jurusan, penyeleksian.status as status from pendaftar"
			+ " join PENYELEKSIAN on pendaftar.no_daftar = penyeleksian.no_daftar"
			+ " join JALUR_MASUK on penyeleksian.id_jalur = jalur_masuk.id_jalur")
	@Results(value = {
			@Result(property = "nama_id", column = "nama_id"),
			@Result(property = "no_id", column ="no_id"),
			@Result(property = "jurusan", column = "jurusan")})
	List<PendaftarModel> selectAllPendaftar();
	
	@Update("UPDATE pendaftar SET nama_id = #{nama_id}, nama_ijazah=#{nama_ijazah}, jenis_kelamin=#{jenis_kelamin}, no_id=#{no_id}, "
			+ "nama_lembaga=#{nama_lembaga}, jurusan=#{jurusan} WHERE no_id=#{no_id}")
	void updateDataPendaftar(PendaftarModel pendaftar);
	
//	@Select("select nama_id, no_id, jurusan, penyeleksian.status as status from pendaftar"
//			+ " join PENYELEKSIAN on pendaftar.no_daftar = penyeleksian.no_daftar"
//			+ " join JALUR_MASUK on penyeleksian.id_jalur = jalur_masuk.id_jalur AND penyeleksian.status=1")
//	@Results(value = {
//			@Result(property = "nama_id", column = "nama_id"),
//			@Result(property = "no_id", column ="no_id"),
//			@Result(property = "jurusan", column = "jurusan")})
//	List<PendaftarModel> selectTerverifikasi();
	
//	@Select("select nama_id, no_id, jurusan, penyeleksian.status as status from pendaftar"
//			+ " join PENYELEKSIAN on pendaftar.no_daftar = penyeleksian.no_daftar"
//			+ " join JALUR_MASUK on penyeleksian.id_jalur = jalur_masuk.id_jalur AND penyeleksian.status=0")
//	@Results(value = {
//			@Result(property = "nama_id", column = "nama_id"),
//			@Result(property = "no_id", column ="no_id"),
//			@Result(property = "jurusan", column = "jurusan")})
//	List<PendaftarModel> selectTakTerverifikasi();
}
