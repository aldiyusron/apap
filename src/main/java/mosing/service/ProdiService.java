package mosing.service;

import java.util.List;

import mosing.model.ProdiTersediaModel;

public interface ProdiService {

	ProdiTersediaModel selectProdi(int id_prodi);
	List<ProdiTersediaModel> selectAllProdi(int id_jalur);
	List<ProdiTersediaModel> selectAllProdiFak(int id_fakultas);
	List<ProdiTersediaModel> selectAllProdiTersedia();
}
