package mosing.service;

import mosing.model.DaftarPilihanModel;
import java.util.List;
import mosing.model.PendaftarModel;
import mosing.model.PenyeleksianModel;

public interface PendaftarService {

	void addPendaftar(PendaftarModel pendaftar);
	PendaftarModel selectPendaftar2(String username);
	void addDaftarPilihan(DaftarPilihanModel daftar);
	void updateFoto(String foto, int id_user);
	PendaftarModel selectPendaftar(String no_id);
	List<PendaftarModel> selectAllPendaftarTerverifikasi();
	List<PendaftarModel> selectAllPendaftarTakTerverifikasi();
	List<PendaftarModel> selectAllPendaftar();
	void updateDataPendaftar(PendaftarModel pendaftar);
	List<PendaftarModel> selectAllPendaftarPPKB();
}