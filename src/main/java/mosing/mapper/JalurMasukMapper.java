package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.annotations.One;
import org.apache.ibatis.annotations.Many;

import mosing.model.JalurMasukModel;
import mosing.model.LokasiModel;
import mosing.model.ProdiTersediaModel;

@Mapper
public interface JalurMasukMapper {

	@Select("SELECT * FROM JALUR_MASUK WHERE id_jalur = #{id_jalur}")
	@Results(value = { @Result(property = "id_jalur", column = "id_jalur"), @Result(property = "nama", column = "nama"),
			@Result(property = "tanggal_buka", column = "tanggal_buka"),
			@Result(property = "tanggal_tutup", column = "tanggal_tutup"),
			@Result(property = "status", column = "status"),
			@Result(property = "nama_jenjang", column = "nama_jenjang"),
			@Result(property = "nama_program", column = "nama_program"),
			@Result(property = "jenis_jalur", column = "jenis_jalur"),
			@Result(property = "persyaratan", column = "persyaratan"),
			@Result(property = "waktu_ujian", column = "waktu_ujian"),
			@Result(property = "listProdi", column = "id_jalur", javaType = List.class, one = @One(select = "selectProdiJalurMasuk")),
			@Result(property = "listLokasi", column = "id_jalur", javaType = List.class, one = @One(select = "selectLokasiJalur"))
	})
	JalurMasukModel selectJalurMasuk(@Param("id_jalur") int id_jalur);

	@Insert("INSERT INTO JALUR_MASUK (nama, tanggal_buka, tanggal_tutup,"
			+ "status, nama_jenjang, nama_program, jenis_jalur, persyaratan, waktu_ujian, flag_aktif) VALUES"
			+ "(#{nama}, #{tanggal_buka}, #{tanggal_tutup}, "
			+ "#{status}, #{nama_jenjang}, #{nama_program}, #{jenis_jalur} ,#{persyaratan}, #{waktu_ujian}, 1)")
	void addJalurMasuk(JalurMasukModel jalur_masuk);

	@Update("UPDATE JALUR_MASUK SET nama = #{nama}, tanggal_buka=#{tanggal_buka}, tanggal_tutup=#{tanggal_tutup}, status=#{status}, "
			+ "nama_jenjang=#{nama_jenjang}, nama_program=#{nama_program}, jenis_jalur = #{jenis_jalur}, persyaratan=#{persyaratan}, waktu_ujian=#{waktu_ujian}, flag_aktif=1 WHERE id_jalur=#{id_jalur}")
	void updateJalurMasuk(JalurMasukModel jalur_masuk);

	@Select("SELECT * FROM JALUR_MASUK WHERE flag_aktif = 1")
	@Results(value = { @Result(property = "nama", column = "nama"),
			@Result(property = "tanggal_buka", column = "tanggal_buka"),
			@Result(property = "tanggal_tutup", column = "tanggal_tutup"),
			@Result(property = "status", column = "status"),
			@Result(property = "nama_jenjang", column = "nama_jenjang"),
			@Result(property = "nama_program", column = "nama_program"),
			@Result(property = "jenis_jalur", column = "jenis_jalur"),
			@Result(property = "persyaratan", column = "persyaratan") })
	List<JalurMasukModel> selectAllJalurMasuk();

	@Select("SELECT * FROM PRODI_TERSEDIA p WHERE p.id_jalur = #{id_jalur}")
	List<ProdiTersediaModel> selectProdiJalurMasuk(@Param("id_jalur") int id_jalur);
	
	@Select("SELECT * FROM LOKASI WHERE id_jalur = #{id_jalur}")
	@Results(value = {
			@Result(property = "alamat", column = "alamat"),
			@Result(property = "no_telp", column = "no_telp"),
			@Result(property = "nama_lokasi", column = "nama_lokasi"),
			@Result(property = "nama_provinsi", column = "nama_provinsi"),
			@Result(property = "nama_kota", column = "nama_kota"),
			@Result(property = "kuota_peng", column = "kuota_peng"),
			@Result(property = "kuota_pendaftar", column = "kuota_pendaftar")
	})
	List<LokasiModel> selectLokasiJalur(@Param("id_jalur") int id_jalur);

	@Update("UPDATE JALUR_MASUK SET flag_aktif = 0 WHERE id_jalur=#{id_jalur}")
	void deleteJalurMasuk(int id_jalur);

	@Select("SELECT p.id_prodi, p.nama_prodi FROM prodi_tersedia p WHERE id_jalur=#{id_jalur} AND flag_aktif=1")
	@Results(value = { @Result(property = "id_prodi", column = "id_prodi"),
			@Result(property = "nama_prodi", column = "nama_prodi") })
	List<ProdiTersediaModel> selectAllProdi(@Param("id_jalur") int id_jalur);

	@Select("SELECT * FROM JALUR_MASUK WHERE jenis_jalur = 1 AND flag_aktif=1")
	List<JalurMasukModel> selectAllJalurTulis();

	@Select("SELECT * FROM JALUR_MASUK WHERE jenis_jalur=0 AND flag_aktif=1")
	List<JalurMasukModel> selectAllJalurUndangan();
	
	@Select("SELECT * FROM JALUR_MASUK WHERE nama = #{nama_jalur}")
	JalurMasukModel selectJalur(@Param("nama_jalur") String nama_jalur);
}