package mosing.service;

import java.util.List;

import mosing.model.JalurMasukModel;

public interface JalurMasukService {
	void deleteJalurMasuk(JalurMasukModel jalurMasuk);
	JalurMasukModel selectJalurMasuk(int id_jalur);
	List<JalurMasukModel> selectAllJalurMasuk();
	
}

