package mosing.service;

import java.util.List;

import mosing.model.ProdiTersediaModel;

public interface ProdiTersediaService {

	ProdiTersediaModel selectProdi(int id_prodi);
	List<ProdiTersediaModel> selectAllProdi(int id_jalur);
	void addProdi(ProdiTersediaModel prodi);
	void updateProdi(ProdiTersediaModel prodi);
	void deleteProdi(ProdiTersediaModel prodi);
}
