package mosing.service;

import mosing.model.JalurMasukModel;

public interface JalurMasukService {
	void deleteJalurMasuk(JalurMasukModel jalurMasuk);
	JalurMasukModel selectJalurMasuk(String id_jalur);
	
}

