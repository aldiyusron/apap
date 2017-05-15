package mosing.service;

import java.util.List;

import mosing.model.FakultasModel;

public interface FakultasService {
	
	FakultasModel selectFakultas(int id_fakultas);
	List<FakultasModel> selectAllFakultas();
}
