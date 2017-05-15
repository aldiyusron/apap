package mosing.service;

import java.util.List;

import mosing.model.PendaftarModel;

public interface PendaftarService {

	void addPendaftar(PendaftarModel pendaftar);
	PendaftarModel selectPendaftar(String no_id);
	List<PendaftarModel> selectAllPendaftarTerverifikasi();
	List<PendaftarModel> selectAllPendaftarTakTerverifikasi();
	List<PendaftarModel> selectAllPendaftar();
	void updateDataPendaftar(PendaftarModel pendaftar);
	PendaftarModel selectPPKB(String no_id);
	PendaftarModel selectPendaftarLulus(int no_daftar);
}
