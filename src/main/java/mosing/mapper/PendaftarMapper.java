package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
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

	@Insert("Insert into daftar_pilihan (no_daftar, jenjang, nama_program, id_prodi, pilihan, flag_aktif) values "
			+ "(#{no_daftar}, #{jenjang}, #{nama_program}, #{id_prodi}, #{pilihan}, 1)")
	void addDaftarPilihan(DaftarPilihanModel daftar);

	@Update("Update pendaftar set foto=#{foto} where no_daftar=#{no_daftar}")
	void updateFoto(@Param("foto") String foto, @Param("no_daftar") int no_daftar);

	@Select("select * from pendaftar p" + " join PENYELEKSIAN on p.no_daftar = penyeleksian.no_daftar"
			+ " WHERE penyeleksian.status=0 and id_jalur=4")
	List<PendaftarModel> selectAllPendaftarTerverifikasi();

	@Select("select p.* from pendaftar p" + " join PENYELEKSIAN on p.no_daftar = penyeleksian.no_daftar"
			+ " WHERE penyeleksian.status=0 and penyeleksian.id_jalur = 4")
	List<PendaftarModel> selectAllPendaftarTakTerverifikasi();

	@Select("select nama_id, no_id, jurusan, penyeleksian.status as status from pendaftar"
			+ " join PENYELEKSIAN on pendaftar.no_daftar = penyeleksian.no_daftar"
			+ " join JALUR_MASUK on penyeleksian.id_jalur = jalur_masuk.id_jalur")
	@Results(value = { @Result(property = "nama_id", column = "nama_id"), @Result(property = "no_id", column = "no_id"),
			@Result(property = "jurusan", column = "jurusan") })
	List<PendaftarModel> selectAllPendaftar();

	@Update("UPDATE pendaftar SET nama_id = #{nama_id}, nama_ijazah=#{nama_ijazah}, jenis_kelamin=#{jenis_kelamin}, no_id=#{no_id}, "
			+ "nama_lembaga=#{nama_lembaga}, jurusan=#{jurusan} WHERE no_daftar=#{no_daftar}")
	void updateDataPendaftar(PendaftarModel pendaftar);

	@Select("select p.* from pendaftar p join penyeleksian pn on pn.no_daftar=p.no_daftar join daftar_pilihan d on pn.no_daftar=d.no_daftar join prodi_tersedia pr on "
			+ "pr.id_prodi = d.id_prodi where pn.status_rekomen=0 and d.id_prodi = #{id_prodi}")
	List<PendaftarModel> selectAllPendaftarNonRec(int id_prodi);

	@Select("select * from pendaftar join penyeleksian on pendaftar.no_daftar = penyeleksian.no_daftar"
			+ "join nilai_rapor on penyeleksian.no_daftar = nilai_rapor.no_daftar" + "where penyeleksian.id_jalur = 4")
	@Results(value = { @Result(property = "nama_id", column = "nama_id"),
			@Result(property = "no_daftar", column = "no_daftar"),
			@Result(property = "nama_lembaga", column = "nama_lembaga"),
			@Result(property = "status_rekomen", column = "status_rekomen") })
	List<PendaftarModel> selectAllPendaftarPPKB();

	@Select("select p.* from pendaftar p join penyeleksian pn on pn.no_daftar=p.no_daftar join daftar_pilihan d on pn.no_daftar=d.no_daftar join prodi_tersedia pr on "
			+ "pr.id_prodi = d.id_prodi where pn.status_rekomen=1 and d.id_prodi = #{id_prodi}")
	List<PendaftarModel> selectAllPendaftarRec(int id_prodi);

	@Select("select * from pendaftar" + " join PENYELEKSIAN on pendaftar.no_daftar = penyeleksian.no_daftar"
			+ " join JALUR_MASUK on penyeleksian.id_jalur = jalur_masuk.id_jalur where jalur_masuk.id_jalur=4 AND no_id=#{no_id}")
	PendaftarModel selectPPKB(@Param("no_id") String no_id);

	@Select("select * from calon_mahasiswa where no_daftar=#{no_daftar}")
	PendaftarModel selectPendaftarLulus(@Param("no_daftar") int no_daftar);

	@Select("select nama_id from pendaftar where no_daftar=#{no_daftar}")
	PendaftarModel selectNama(@Param("no_daftar") int no_daftar);

	@Delete("DELETE FROM PENDAFTAR WHERE no_daftar=#{no_daftar}")
	void deletePendaftar(@Param("no_daftar") int no_daftar);

	@Update("UPDATE PENDAFTAR SET no_hp = #{no_hp}, no_telp=#{no_telp}, nama_negara=#{nama_negara}, "
			+ "kewarganegaraan=#{kewarganegaraan}, alamat_tetap=#{alamat_tetap}, alamat_sekarang=#{alamat_sekarang}, "
			+ "tgl_lahir=#{tgl_lahir}, nama_provinsi=#{nama_provinsi}, nama_kota=#{nama_kota} where no_daftar=#{no_daftar}")
	void updateDataDiriLengkap(PendaftarModel pendaftar);
}
