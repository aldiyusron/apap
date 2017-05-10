package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import mosing.model.DaftarPilihanModel;
import mosing.model.PendaftarModel;

@Mapper
public interface PendaftarMapper {

	@Select("select u.id_user, u.username, p.* from user u, pendaftar p where u.username = #{username} and u.id_user = p.id_user")
	PendaftarModel selectPendaftar2(@Param("username") String username);

	@Select("select * from pendaftar where no_id=#{no_id}")
	PendaftarModel selectPendaftar(@Param("no_id") String no_id);

	@Insert("INSERT INTO pendaftar (id_user, no_id, nama_id, "
			+ "nama_ijazah, foto, no_hp, no_telp, nama_negara, kewarganegaraan, alamat_tetap, "
			+ "jenis_id, alamat_sekarang, tgl_lahir, nama_provinsi, nama_kota, jenis_kelamin, nama_lembaga, jurusan) VALUES"
			+ "(#{id_user}, #{no_id}, #{nama_id}, "
			+ "#{nama_ijazah}, #{foto}, #{no_hp}, #{no_telp}, #{nama_negara}, #{kewarganegaraan},"
			+ "#{alamat_tetap}, #{jenis_id}, #{alamat_sekarang}, #{tgl_lahir}, #{nama_provinsi}, "
			+ "#{nama_kota}, #{jenis_kelamin}, #{nama_lembaga}, #{jurusan})")
	void addPendaftar(PendaftarModel pendaftar);

	@Insert("Insert into daftar_pilihan (no_daftar, jenjang, nama_program, id_prodi, pilihan) values "
			+ "(#{no_daftar}, #{jenjang}, #{nama_program}, #{id_prodi}, #{pilihan})")
	void addDaftarPilihan(DaftarPilihanModel daftar);

	@Update("Update pendaftar set foto=#{foto} where id_user=#{id_user}")
	void updateFoto(@Param("foto") String foto, @Param("id_user") int id_user);

	@Select("select p.* from pendaftar p" + " join PENYELEKSIAN on p.no_daftar = penyeleksian.no_daftar"
			+ " WHERE penyeleksian.status=0 and p.id_user=5")
	List<PendaftarModel> selectAllPendaftarTerverifikasi();

	@Select("select p.* from pendaftar p" + " join PENYELEKSIAN on p.no_daftar = penyeleksian.no_daftar"
			+ " WHERE penyeleksian.status=0 and p.id_user=5")
	List<PendaftarModel> selectAllPendaftarTakTerverifikasi();

	@Select("select nama_id, no_id, jurusan, penyeleksian.status as status from pendaftar"
			+ " join PENYELEKSIAN on pendaftar.no_daftar = penyeleksian.no_daftar"
			+ " join JALUR_MASUK on penyeleksian.id_jalur = jalur_masuk.id_jalur")
	@Results(value = { @Result(property = "nama_id", column = "nama_id"), @Result(property = "no_id", column = "no_id"),
			@Result(property = "jurusan", column = "jurusan") })
	List<PendaftarModel> selectAllPendaftar();

	@Update("UPDATE pendaftar SET nama_id = #{nama_id}, nama_ijazah=#{nama_ijazah}, jenis_kelamin=#{jenis_kelamin}, no_id=#{no_id}, "
			+ "nama_lembaga=#{nama_lembaga}, jurusan=#{jurusan} WHERE no_id=#{no_id}")
	void updateDataPendaftar(PendaftarModel pendaftar);

}