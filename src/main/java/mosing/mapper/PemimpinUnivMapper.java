package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import mosing.model.PendaftarModel;

@Mapper
public interface PemimpinUnivMapper {
	@Select("")
	List<PendaftarModel> selectAllPendaftar(); //dari tabel pendaftar
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarLulus(int status); //dari tabel penyeleksian
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarS1(int jenjang); //dari tabel daftar_pilihan
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarS1Lulus(int status); //dari tabel penyeleksian & daftar_pilihan
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarS2(int jenjang); //dari tabel daftar_pilihan
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarS2Lulus(int status); //dari tabel penyeleksian & daftar_pilihan
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarS3(int jenjang); //dari tabel daftar_pilihan
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarS3Lulus(int status); //dari tabel penyeleksian & daftar_pilihan
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarReguler(int nama_program); //dari tabel daftar_pilihan
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarRegulerLulus(int status); //dari tabel penyeleksian & daftar_pilihan
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarParalel(int nama_program); //dari tabel daftar_pilihan
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarParalelLulus(int status); //dari tabel penyeleksian & daftar_pilihan
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarInternasional(int nama_program); //dari tabel daftar_pilihan
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarInternasionalLulus(int status); //dari tabel penyeleksian & daftar_pilihan
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarFakultas(int id_prodi); //dari tabel daftar_pilihan
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarFakultasLulus(int status); //dari tabel penyeleksian & daftar_pilihan
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarProdi(int id_prodi); //dari tabel daftar_pilihan
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarProdiLulus(int status); //dari tabel penyeleksian & daftar_pilihan
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarSNMPTN(int id_jalur);
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarSNMPTNLulus(int status);
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarPPKB(int id_jalur);
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarPPKBLulus(int status);
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarTalentScouting(int id_jalur);
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarTalentScoutingLulus(int status);
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarSIMAK(int id_jalur);
	
	@Select("")
	List<PendaftarModel> selectAllPendaftatSIMAKLulus(int status);
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarOlim(int id_jalur);
	
	@Select("")
	List<PendaftarModel> selectAllPendaftarOlimLulus(int status);
}
