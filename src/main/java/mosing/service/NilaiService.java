package mosing.service;

import java.util.List;

import mosing.model.NilaiModel;

public interface NilaiService {
	void addNilai(NilaiModel nilai);
	void updateNilai(NilaiModel nilai);
	List<NilaiModel> selectNilai(int no_daftar);
}
