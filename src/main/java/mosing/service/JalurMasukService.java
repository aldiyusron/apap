package mosing.service;

import java.util.List;

import mosing.model.JalurMasukModel;

public interface JalurMasukService {
	JalurMasukModel selectJalurMasuk(int id_jalur);
	List<JalurMasukModel> selectAllJalurMasuk();
	void addJalurMasuk(JalurMasukModel jalur_masuk);
	void updateJalurMasuk(JalurMasukModel jalur_masuk);
}