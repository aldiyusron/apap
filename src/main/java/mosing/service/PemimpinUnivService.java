package mosing.service;

import java.util.List;

import mosing.model.PendaftarModel;

public interface PemimpinUnivService {
	List<PendaftarModel> selectAllPendaftar(); 
	List<PendaftarModel> selectAllPendaftarLulus(int status); 
	List<PendaftarModel> selectAllPendaftarS1(int jenjang); 
	List<PendaftarModel> selectAllPendaftarS1Lulus(int status); 
	List<PendaftarModel> selectAllPendaftarS2(int jenjang); 
	List<PendaftarModel> selectAllPendaftarS2Lulus(int status); 
	List<PendaftarModel> selectAllPendaftarS3(int jenjang); 
	List<PendaftarModel> selectAllPendaftarS3Lulus(int status); 
	List<PendaftarModel> selectAllPendaftarReguler(int nama_program); 
	List<PendaftarModel> selectAllPendaftarRegulerLulus(int status); 
	List<PendaftarModel> selectAllPendaftarParalel(int nama_program); 
	List<PendaftarModel> selectAllPendaftarParalelLulus(int status); 
	List<PendaftarModel> selectAllPendaftarInternasional(int nama_program); 
	List<PendaftarModel> selectAllPendaftarInternasionalLulus(int status); 
	List<PendaftarModel> selectAllPendaftarFakultas(int id_prodi); 
	List<PendaftarModel> selectAllPendaftarFakultasLulus(int status);
	List<PendaftarModel> selectAllPendaftarProdi(int id_prodi); 
	List<PendaftarModel> selectAllPendaftarProdiLulus(int status); 
	List<PendaftarModel> selectAllPendaftarSNMPTN(int id_jalur); //DONE
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
