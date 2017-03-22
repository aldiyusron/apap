package mosing.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import mosing.model.PengawasUjianModel;

@Mapper
public interface PengawasUjianMapper {

	@Insert("insert into pengawas_ujian (username, status, jabatan, nama, lokasi) values "
			+ "(#{username}, #{status}, #{jabatan}, #{nama}, #{lokasi})")
	void addPengawas(PengawasUjianModel pengawas);
	
	@Select("select * from pengawas_ujian where username = #{username}")
	PengawasUjianModel selectPengawas(@Param("username") String username);
}
