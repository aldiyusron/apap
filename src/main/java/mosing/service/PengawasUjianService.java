package mosing.service;

import mosing.model.PengawasUjianModel;

public interface PengawasUjianService {

	void addPengawas(PengawasUjianModel pengawas);
	PengawasUjianModel selectPengawas(String username);
}
