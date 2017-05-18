package mosing.service;

import mosing.model.CalonMahasiswaModel;

public interface CalonMahasiswaService {
	CalonMahasiswaModel selectCalon(int no_daftar);
	void addCalon(CalonMahasiswaModel calon);
}
