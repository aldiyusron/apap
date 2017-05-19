package mosing.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import mosing.model.RiwayatPendaftaranModel;

@Mapper
public interface RiwayatPendaftaranMapper {
	
	@Insert("insert into riwayat_pendaftaran (no_pendaftaran, tahun, id_jalur, nama_jenjang, nama_program) values (#{no_pendaftaran},#{tahun},#{id_jalur},#{nama_jenjang},#{nama_program})")
	void addRiwayat(RiwayatPendaftaranModel riwayat);

	@Select("select * from riwayat_pendaftaran where no_pendaftaran=#{no_daftar}")
	RiwayatPendaftaranModel viewRiwayat(int no_daftar);
}
