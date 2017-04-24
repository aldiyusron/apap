package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.annotations.Many;

import mosing.model.JalurMasukModel;
import mosing.model.ProdiTersediaModel;

@Mapper
public interface JalurMasukMapper {

	@Select("select p.id_prodi, p.nama_prodi from prodi_tersedia p where id_jalur=#{id_jalur}")
	@Results(value = { @Result(property = "id_prodi", column = "id_prodi"),
			@Result(property = "nama_prodi", column = "nama_prodi") })
	List<ProdiTersediaModel> selectAllProdi(@Param("id_jalur") int id_jalur);

	@Select("select * from jalur_masuk where id_jalur = #{id_jalur} and flag_aktif=1")
	@Results(value = { @Result(property = "id_jalur", column = "id_jalur"), @Result(property = "nama", column = "nama"),
			@Result(property = "tanggal_buka", column = "tanggal_buka"),
			@Result(property = "tanggal_tutup", column = "tanggal_tutup"),
			@Result(property = "status", column = "status"),
			@Result(property = "nama_jenjang", column = "nama_jenjang"),
			@Result(property = "nama_program", column = "nama_program"),
			@Result(property = "persyaratan", column = "persyaratan"),
			@Result(property = "flag_aktif", column = "flag_aktif"),
			@Result(property = "listProdi", column = "id_prodi", javaType = List.class, many = @Many(select = "selectAllProdi")) })
	JalurMasukModel selectJalurMasukdanProdi(@Param("id_jalur") int id_jalur);

	// @Select("select p.id_prodi, p.nama_prodi where prodi_tersedia p join
	// jalur_masuk j on p.id_jalur=j.id_jalur where p.id_jalur=#{id_jalur}")
	// @Results(value = {
	// @Result(property="id_prodi", column="id_prodi"),
	// @Result(property="nama_prodi", column="nama_prodi"),
	// @Result(property="daya_tampung", column="daya_tampung"),
	// @Result(property="nama_fakultas", column="nama_fakultas")
	// })
	// List<ProdiTersediaModel> selectAllProdi(@Param("id_jalur") int id_jalur);

	@Insert("INSERT INTO jalur_masuk (nama, tanggal_buka, tanggal_tutup,"
			+ "status, nama_jenjang, nama_program, persyaratan, flag_aktif) VALUES"
			+ "(#{nama}, #{tanggal_buka}, #{tanggal_tutup}, "
			+ "#{status}, #{nama_jenjang}, #{nama_program}, #{persyaratan}, #{flag_aktif})")
	void addJalurMasuk(JalurMasukModel jalur_masuk);

	@Update("UPDATE jalur_masuk SET nama = #{nama}, tanggal_buka=#{tanggal_buka}, tanggal_tutup=#{tanggal_tutup}, status=#{status}, "
			+ "nama_jenjang=#{nama_jenjang}, nama_program=#{nama_program}, persyaratan=#{persyaratan}, flag_aktif=#{flag_aktif} WHERE id_jalur=#{id_jalur}")
	void updateJalurMasuk(JalurMasukModel jalur_masuk);

	@Select("select id_jalur, nama, tanggal_buka, tanggal_tutup, status, nama_jenjang, nama_program, persyaratan from jalur_masuk where flag_aktif = 1")
	@Results(value = { 
			@Result(property = "id_jalur", column = "id_jalur"), @Result(property = "nama", column = "nama"),
			@Result(property = "tanggal_buka", column = "tanggal_buka"),
			@Result(property = "tanggal_tutup", column = "tanggal_tutup"),
			@Result(property = "status", column = "status"),
			@Result(property = "nama_jenjang", column = "nama_jenjang"),
			@Result(property = "nama_program", column = "nama_program"),
			@Result(property = "persyaratan", column = "persyaratan") })
	List<JalurMasukModel> selectAllJalurMasuk();
}