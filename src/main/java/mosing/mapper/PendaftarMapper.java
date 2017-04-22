package mosing.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import mosing.model.PendaftarModel;

@Mapper
public interface PendaftarMapper {

	@Select("select * from pendaftar where username = #{username}")
	PendaftarModel selectPendaftar(@Param("username") String username);
	
	@Select("select * from pendaftar where nisn = #{nisn}")
	PendaftarModel selectPendaftar2(@Param("nisn") int nisn);

	@Insert("INSERT INTO pendaftar (id_user, no_id, nama_id, "
			+ "nama_ijazah, foto, no_hp, no_telp, nama_negara, kewarganegaraan, alamat_tetap, "
			+ "jenis_id, alamat_sekarang, tgl_lahir, nama_provinsi, nama_kota, jenis_kelamin, "
			+ "nama_lembaga, jurusan, no_daftar) VALUES "
			+ "(#{id_user}, #{no_id}, #{nama_id}, "
			+ "#{nama_ijazah}, #{foto}, #{no_hp}, #{no_telp}, #{nama_negara}, #{kewarganegaraan},"
			+ "#{alamat_tetap}, #{jenis_id}, #{alamat_sekarang}, #{tgl_lahir}, #{nama_provinsi}, "
			+ "#{nama_kota}, #{jenis_kelamin}, #{nama_lembaga}, #{jurusan}, #{no_daftar})")
	void addPendaftar(PendaftarModel pendaftar);
	
	@Insert("insert into pendaftar (nama_id, nama_ijazah, nisn, nama_lembaga)")
	void addPendaftar2(PendaftarModel pendaftar);
}
