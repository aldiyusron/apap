package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.One;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import mosing.model.LokasiModel;
import mosing.model.PengawasUjianModel;

@Mapper
public interface PengawasUjianMapper {

	@Insert("insert into pengawas_ujian (id_user, status, jabatan, nama, no_hp, id_lokasi, pindah_bool, flag_aktif) values "
			+ "(#{id_user}, #{status}, #{jabatan}, #{nama}, #{no_hp}, #{id_lokasi}, #{pindah_bool}, 1)")
	void addPengawas(PengawasUjianModel pengawas);

	@Select("select u.id_user, u.username, pu.* from user u, pengawas_ujian pu where u.username = #{username} and u.id_user = pu.id_user")
	PengawasUjianModel selectPengawas(@Param("username") String username);

	@Select("select * from pengawas_ujian where flag_aktif = 1")
	@Results(value = { @Result(property = "id_user", column = "id_user"), 
			@Result(property = "nama", column = "nama"),
			@Result(property = "jabatan", column = "jabatan"),
			@Result(property = "no_hp", column = "no_hp"),
			@Result(property = "id_lokasi", column = "id_lokasi"),
			@Result(property = "pindah_bool", column = "pindah_bool"),
			@Result(property = "status", column = "status")
	})
	List<PengawasUjianModel> selectAllPengawas();
	
	@Select("select * from pengawas_ujian where id_lokasi = #{id_lokasi} and status = 1 and flag_aktif = 1")
	@Results(value = { @Result(property = "id_user", column = "id_user"), 
			@Result(property = "nama", column = "nama"),
			@Result(property = "jabatan", column = "jabatan"),
			@Result(property = "no_hp", column = "no_hp"),
			@Result(property = "id_lokasi", column = "id_lokasi"),
			@Result(property = "pindah_bool", column = "pindah_bool"),
			@Result(property = "status", column = "status")
	})
	List<PengawasUjianModel> selectPengawasUjianTerseleksi(@Param("id_lokasi") int id_lokasi);
	
	@Select("select * from pengawas_ujian where status=0 and id_lokasi = #{id_lokasi} and flag_aktif = 1")
	@Results(value = { @Result(property = "id_user", column = "id_user"), 
			@Result(property = "nama", column = "nama"),
			@Result(property = "jabatan", column = "jabatan"),
			@Result(property = "no_hp", column = "no_hp"),
			@Result(property = "id_lokasi", column = "id_lokasi"),
			@Result(property = "pindah_bool", column = "pindah_bool"),
			@Result(property = "status", column = "status")
	})
	List<PengawasUjianModel> selectPengawasUjianLokasi(@Param("id_lokasi") int id_lokasi);

	@Update("update pengawas_ujian set status = 1 where id_user=#{id_user}")
	void terimaPengawas(@Param("id_user") int id_user);
	
	@Update("update pengawas_ujian set id_user = #{id_user}, status = #{status}, jabatan = #{jabatan}, nama = #{nama}, no_hp = #{no_hp}, id_lokasi = #{id_lokasi}, pindah_bool = #{pindah_bool}, flag_aktif = 1 where id_lokasi = #{id_lokasi}")
	void updatePengawas(PengawasUjianModel pengawas);

	@Update("update pengawas_ujian set status = 0 where id_user=#{id_user}")
	void tolakPengawas(PengawasUjianModel pengawas);
	
	@Select("select * from pengawas_ujian where id_user = #{id_user}")
	PengawasUjianModel selectPengawasPindah(int id_user);
}
