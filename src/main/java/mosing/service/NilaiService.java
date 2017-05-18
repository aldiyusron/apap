package mosing.service;

import java.util.List;

import mosing.model.NilaiModel;
import mosing.model.NilaiUjianModel;

public interface NilaiService {
	void addNilai(NilaiModel nilai);
	void updateNilai(NilaiModel nilai);
	List<NilaiModel> selectNilai(int no_daftar);
	NilaiUjianModel selectNilaiUjian(int no_daftar);
}
