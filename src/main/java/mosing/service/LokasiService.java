package mosing.service;

import java.util.List;

import mosing.model.LokasiModel;

public interface LokasiService {
	void addLokasiUjian (LokasiModel lokasi);
	void updateLokasiUjian (LokasiModel lokasi);
	void deleteLokasiUjian (LokasiModel lokasi);
	List<LokasiModel> selectAllLokasi();
	List<LokasiModel> selectLokasiJalur(int id_jalur);
	LokasiModel selectLokasi(int id_lokasi);
}
