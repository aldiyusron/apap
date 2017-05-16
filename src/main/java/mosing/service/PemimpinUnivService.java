package mosing.service;

import java.util.List;

import mosing.model.PendaftarModel;

public interface PemimpinUnivService {
	List<PendaftarModel> selectAllPendaftar(); //dari tabel pendaftar
	List<PendaftarModel> selectAllPendaftarLulus(int status); //dari tabel penyeleksian
	List<PendaftarModel> selectAllPendaftarS1(int jenjang); //dari tabel daftar_pilihan
	List<PendaftarModel> selectAllPendaftarS1Lulus(int status); //dari tabel penyeleksian & daftar_pilihan
	List<PendaftarModel> selectAllPendaftarS2(int jenjang); //dari tabel daftar_pilihan
	List<PendaftarModel> selectAllPendaftarS2Lulus(int status); //dari tabel penyeleksian & daftar_pilihan
	List<PendaftarModel> selectAllPendaftarS3(int jenjang); //dari tabel daftar_pilihan
	List<PendaftarModel> selectAllPendaftarS3Lulus(int status); //dari tabel penyeleksian & daftar_pilihan
	List<PendaftarModel> selectAllPendaftarReguler(int nama_program); //dari tabel daftar_pilihan
	List<PendaftarModel> selectAllPendaftarRegulerLulus(int status); //dari tabel penyeleksian & daftar_pilihan
	List<PendaftarModel> selectAllPendaftarParalel(int nama_program); //dari tabel daftar_pilihan
	List<PendaftarModel> selectAllPendaftarParalelLulus(int status); //dari tabel penyeleksian & daftar_pilihan
	List<PendaftarModel> selectAllPendaftarInternasional(int nama_program); //dari tabel daftar_pilihan
	List<PendaftarModel> selectAllPendaftarInternasionalLulus(int status); //dari tabel penyeleksian & daftar_pilihan
	List<PendaftarModel> selectAllPendaftarFakultas(int id_prodi); //dari tabel daftar_pilihan
	List<PendaftarModel> selectAllPendaftarFakultasLulus(int status); //dari tabel penyeleksian & daftar_pilihan
	List<PendaftarModel> selectAllPendaftarProdi(int id_prodi); //dari tabel daftar_pilihan
	List<PendaftarModel> selectAllPendaftarProdiLulus(int status); //dari tabel penyeleksian & daftar_pilihan
	List<PendaftarModel> selectAllPendaftarSNMPTN(int id_jalur);
	List<PendaftarModel> selectAllPendaftarSNMPTNLulus(int status);
	List<PendaftarModel> selectAllPendaftarPPKB(int id_jalur);
	List<PendaftarModel> selectAllPendaftarPPKBLulus(int status);
	List<PendaftarModel> selectAllPendaftarTalentScouting(int id_jalur);
	List<PendaftarModel> selectAllPendaftarTalentScoutingLulus(int status);
	List<PendaftarModel> selectAllPendaftarSIMAK(int id_jalur);
	List<PendaftarModel> selectAllPendaftatSIMAKLulus(int status);
	List<PendaftarModel> selectAllPendaftarOlim(int id_jalur);
	List<PendaftarModel> selectAllPendaftarOlimLulus(int status);
}
