package mosing.service;

import mosing.model.DaftarPilihanModel;
import mosing.model.PendaftarModel;
import mosing.model.PenyeleksianModel;

public interface PendaftarService {

	void addPendaftar(PendaftarModel pendaftar);
	PendaftarModel selectPendaftar(String username);
	void addDaftarPilihan(DaftarPilihanModel daftar);
	void updateFoto(String foto, String id_user);
}
