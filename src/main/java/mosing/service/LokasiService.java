package mosing.service;

import java.util.List;

import mosing.model.LokasiModel;

public interface LokasiService {

	LokasiModel selectLokasi(String nama_lokasi);
	List<LokasiModel> selectAllLokasi();
}
