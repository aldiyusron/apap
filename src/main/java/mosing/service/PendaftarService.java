package mosing.service;

import java.util.List;

import mosing.model.PendaftarModel;

public interface PendaftarService {

	void addPendaftar(PendaftarModel pendaftar);
	PendaftarModel selectPendaftar(String no_id);
	List<PendaftarModel> selectAllPendaftarTerverifikasi(Integer id_value);
	List<PendaftarModel> selectAllPendaftarTakTerverifikasi(Integer id_value);
	List<PendaftarModel> selectAllPendaftar();
	List<PendaftarModel> selectTakTerverifikasi();
	List<PendaftarModel> selectTerverifikasi();
}
