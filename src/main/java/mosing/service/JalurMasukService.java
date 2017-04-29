package mosing.service;

import java.util.List;

import mosing.model.JalurMasukModel;
import mosing.model.ProdiTersediaModel;

public interface JalurMasukService {
	void deleteJalurMasuk(int id_jalur);
	JalurMasukModel selectJalurMasuk(int id_jalur);
	List<JalurMasukModel> selectAllJalurMasuk();
	void addJalurMasuk(JalurMasukModel jalur_masuk);
	void updateJalurMasuk(JalurMasukModel jalur_masuk);
	List<ProdiTersediaModel> selectProdiJalurMasuk(int id_jalur);
	List<ProdiTersediaModel> selectAllProdi(int id_jalur);
	List<JalurMasukModel> selectAllJalurTulis();
}