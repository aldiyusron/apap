package mosing.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import mosing.model.PengawasUjianModel;

@Mapper
public interface PengawasUjianMapper {

	@Insert("insert into pengawas_ujian (username, status, jabatan, nama, lokasi) values "
			+ "(#{username}, #{status}, #{jabatan}, #{nama}, #{lokasi})")
	void addPengawas(PengawasUjianModel pengawas);
}
