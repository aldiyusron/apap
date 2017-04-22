package mosing.service;

import mosing.model.PendaftarModel;
import mosing.model.PenyeleksianModel;

public interface PendaftarService {

	void addPendaftar(PendaftarModel pendaftar);
	PendaftarModel selectPendaftar(String no_id);
	PenyeleksianModel selectPenyeleksian(String no_daftar);
}
