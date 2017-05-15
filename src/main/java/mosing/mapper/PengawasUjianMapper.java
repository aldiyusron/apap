package mosing.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import mosing.model.PengawasUjianModel;

@Mapper
public interface PengawasUjianMapper {

	@Insert("insert into pengawas_ujian (id_user, status, jabatan, nama, no_hp, id_lokasi, pindah_bool, flag_aktif) values "
			+ "(#{id_user}, #{status}, #{jabatan}, #{nama}, #{no_hp}, #{id_lokasi}, #{pindah_bool}, 1)")
	void addPengawas(PengawasUjianModel pengawas);

	@Select("select u.id_user, u.username, pu.* from user u, pengawas_ujian pu where u.username = #{username} and u.id_user = pu.id_user")
	PengawasUjianModel selectPengawas(@Param("username") String username);
}
