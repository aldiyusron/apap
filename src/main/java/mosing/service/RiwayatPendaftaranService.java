package mosing.service;

import mosing.model.RiwayatPendaftaranModel;

public interface RiwayatPendaftaranService {
	void addRiwayat(RiwayatPendaftaranModel riwayat);
	RiwayatPendaftaranModel viewRiwayat(int no_daftar);
}
