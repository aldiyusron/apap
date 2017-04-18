package mosing.service;

import mosing.model.JalurMasukModel;

public interface JalurMasukService {
	void deleteJalurMasuk(JalurMasukModel jalurMasuk);
	JalurMasukModel selectJalurMasuk(int id_jalur);
	
}

