package mosing.service;

import mosing.model.PendaftarModel;

public interface PendaftarService {

	void addPendaftar(PendaftarModel pendaftar);
	void addPendaftar2(PendaftarModel pendaftar);
	PendaftarModel selectPendaftar(String no_id);
}
