package mosing.service;

import java.util.List;

import mosing.model.DaftarPilihanModel;

public interface DaftarPilihanService {
	List<DaftarPilihanModel> selectPilihan(int no_daftar);
	DaftarPilihanModel selectPilihan2(int no_daftar);
}
