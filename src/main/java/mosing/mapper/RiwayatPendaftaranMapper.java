package mosing.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import mosing.model.RiwayatPendaftaranModel;

@Mapper
public interface RiwayatPendaftaranMapper {
	
	@Insert("INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran, tahun, id_jalur, nama_jenjang, nama_program) VALUES (#{no_pendaftaran},#{tahun},#{id_jalur},#{nama_jenjang},#{nama_program})")
	void addRiwayat(RiwayatPendaftaranModel riwayat);

	@Select("SELECT * FROM RIWAYAT_PENDAFTARAN WHERE no_pendaftaran=#{no_daftar}")
	RiwayatPendaftaranModel viewRiwayat(int no_daftar);
}
