package mosing.service;

import mosing.model.DaftarPilihanModel;
import java.util.List;
import mosing.model.PendaftarModel;
import mosing.model.PenyeleksianModel;

public interface PendaftarService {

	void addPendaftar(PendaftarModel pendaftar);
	PendaftarModel selectPendaftar2(String username);
	void addDaftarPilihan(DaftarPilihanModel daftar);
	void updateFoto(String foto, int no_daftar);
	PendaftarModel selectPendaftar(String no_id);
	List<PendaftarModel> selectAllPendaftarTerverifikasi();
	List<PendaftarModel> selectAllPendaftarTakTerverifikasi();
	List<PendaftarModel> selectAllPendaftar();
	void updateDataPendaftar(PendaftarModel pendaftar);
	List<PendaftarModel> selectAllPendaftarPPKB();
	List<PendaftarModel> selectAllPendaftarNonRec(int id_prodi);
	List<PendaftarModel> selectAllPendaftarRec(int id_fakultas);
	PendaftarModel selectPPKB(String no_id);
	PendaftarModel selectPendaftarLulus(int no_daftar);
	PendaftarModel selectNama(int no_daftar);
	void deletePendaftar(int no_daftar);
	void updateDataDiriLengkap(PendaftarModel pendaftar);
	List<PendaftarModel> selectAllPendaftarSemua(int id_prodi, int id_jalur);
	PendaftarModel selectPendaftar3(int no_daftar);
}
