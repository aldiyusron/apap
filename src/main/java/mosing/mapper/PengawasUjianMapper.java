package mosing.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import mosing.model.PengawasUjianModel;

@Mapper
public interface PengawasUjianMapper {

	@Insert("INSERT INTO PENGAWAS_UJIAN (id_user, status, jabatan, nama, id_lokasi) VALUES "
			+ "(#{id_user}, #{status}, #{jabatan}, #{nama}, #{id_lokasi})")
	void addPengawas(PengawasUjianModel pengawas);

	@Select("SELECT u.id_user, u.username, pu.* FROM USER u, pengawas_ujian pu WHERE u.username = #{username} AND u.id_user = pu.id_user")
	PengawasUjianModel selectPengawas(@Param("username") String username);
}
