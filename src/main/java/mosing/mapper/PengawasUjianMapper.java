package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import mosing.model.PengawasUjianModel;

@Mapper
public interface PengawasUjianMapper {

	@Insert("INSERT INTO PENGAWAS_UJIAN (id_user, status, jabatan, nama, no_hp, id_lokasi, pindah_bool, flag_aktif) VALUES "
			+ "(#{id_user}, #{status}, #{jabatan}, #{nama}, #{no_hp}, #{id_lokasi}, #{pindah_bool}, 1)")
	void addPengawas(PengawasUjianModel pengawas);

	@Select("SELECT u.id_user, u.username, pu.* FROM USER u, PENGAWAS_UJIAN pu WHERE u.username = #{username} AND u.id_user = pu.id_user")
	PengawasUjianModel selectPengawas(@Param("username") String username);

	@Select("SELECT * FROM PENGAWAS_UJIAN WHERE flag_aktif = 1")
	@Results(value = { @Result(property = "id_user", column = "id_user"), 
			@Result(property = "nama", column = "nama"),
			@Result(property = "jabatan", column = "jabatan"),
			@Result(property = "no_hp", column = "no_hp"),
			@Result(property = "id_lokasi", column = "id_lokasi"),
			@Result(property = "pindah_bool", column = "pindah_bool"),
			@Result(property = "status", column = "status")
	})
	List<PengawasUjianModel> selectAllPengawas();
	
	@Select("SELECT * FROM PENGAWAS_UJIAN WHERE id_lokasi = #{id_lokasi} AND status = 1 AND flag_aktif = 1")
	@Results(value = { @Result(property = "id_user", column = "id_user"), 
			@Result(property = "nama", column = "nama"),
			@Result(property = "jabatan", column = "jabatan"),
			@Result(property = "no_hp", column = "no_hp"),
			@Result(property = "id_lokasi", column = "id_lokasi"),
			@Result(property = "pindah_bool", column = "pindah_bool"),
			@Result(property = "status", column = "status")
	})
	List<PengawasUjianModel> selectPengawasUjianTerseleksi(@Param("id_lokasi") int id_lokasi);
	
	@Select("SELECT * FROM PENGAWAS_UJIAN WHERE status=0 AND id_lokasi = #{id_lokasi} AND flag_aktif = 1")
	@Results(value = { @Result(property = "id_user", column = "id_user"), 
			@Result(property = "nama", column = "nama"),
			@Result(property = "jabatan", column = "jabatan"),
			@Result(property = "no_hp", column = "no_hp"),
			@Result(property = "id_lokasi", column = "id_lokasi"),
			@Result(property = "pindah_bool", column = "pindah_bool"),
			@Result(property = "status", column = "status")
	})
	List<PengawasUjianModel> selectPengawasUjianLokasi(@Param("id_lokasi") int id_lokasi);

	@Update("UPDATE PENGAWAS_UJIAN SET status = 1 WHERE id_user=#{id_user}")
	void terimaPengawas(@Param("id_user") int id_user);
	
	@Update("UPDATE PENGAWAS_UJIAN SET id_user = #{id_user}, status = #{status}, jabatan = #{jabatan}, nama = #{nama}, no_hp = #{no_hp}, id_lokasi = #{id_lokasi}, pindah_bool = #{pindah_bool}, flag_aktif = 1 WHERE id_lokasi = #{id_lokasi}")
	void updatePengawas(PengawasUjianModel pengawas);

	@Update("UPDATE PENGAWAS_UJIAN SET status = 0 WHERE id_user=#{id_user}")
	void tolakPengawas(PengawasUjianModel pengawas);
	
	@Select("SELECT * FROM PENGAWAS_UJIAN WHERE id_user = #{id_user}")
	PengawasUjianModel selectPengawasPindah(int id_user);
}