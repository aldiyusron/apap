package mosing.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import mosing.model.PendaftarModel;
import mosing.model.PenyeleksianModel;

@Mapper
public interface PendaftarMapper {

	@Select("select u.id_user, u.username, p.* from user u, pendaftar p where u.username = #{username} and u.id_user = p.id_user")
	PendaftarModel selectPendaftar(@Param("username") String username);

	@Insert("INSERT INTO pendaftar (id_user, no_id, nama_id, "
			+ "nama_ijazah, foto, no_hp, no_telp, nama_negara, kewarganegaraan, alamat_tetap, "
			+ "jenis_id, alamat_sekarang, tgl_lahir, nama_provinsi, nama_kota, jenis_kelamin, nama_lembaga, jurusan) VALUES"
			+ "(#{id_user}, #{no_id}, #{nama_id}, "
			+ "#{nama_ijazah}, #{foto}, #{no_hp}, #{no_telp}, #{negara}, #{kewarganegaraan},"
			+ "#{alamat_tetap}, #{jenis_id}, #{alamat_sekarang}, #{tgl_lahir}, #{provinsi}, "
			+ "#{kota}, #{jenis_kelamin}, #{nama_lembaga}, #{jurusan})")
	void addPendaftar(PendaftarModel pendaftar);
	
	@Select("select * from penyeleksian where no_daftar = #{no_daftar}")
	PenyeleksianModel selectPenyeleksian(@Param("no_daftar") String no_daftar);
}
