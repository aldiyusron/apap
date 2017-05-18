package mosing.service;

import java.util.List;

import mosing.model.FakultasModel;
import mosing.model.ProdiTersediaModel;

public interface FakultasService {
	List<FakultasModel> selectAllFakultas();
	FakultasModel selectFakultasDanProdi(int id_fakultas);
	List<ProdiTersediaModel> selectProdi(int id_fakultas);
	FakultasModel selectFakultas(int id_fakultas);
	
}
