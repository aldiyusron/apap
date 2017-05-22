package mosing.service;

import java.util.List;

import mosing.model.CalonMahasiswaModel;

public interface CalonMahasiswaService {
	CalonMahasiswaModel selectCalon(int no_daftar);
	void addCalon(CalonMahasiswaModel calon);
	List<CalonMahasiswaModel> selectAllCalon();
}
