package mosing.service;

import java.util.List;

import mosing.model.JalurMasukModel;
import mosing.model.ProdiModel;

public interface ProdiService {
//	JalurMasukModel selectJalurMasuk(int id_jalur);
	List<ProdiModel> selectAllProdi(int id_jalur);
//	void addJalurMasuk(JalurMasukModel jalur_masuk);
//	void updateJalurMasuk(JalurMasukModel jalur_masuk);
//	List<ProdiModel> selectProdiJalurMasuk();
}
