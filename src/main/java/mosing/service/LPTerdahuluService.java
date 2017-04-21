package mosing.service;

import java.util.List;

import mosing.model.LPTerdahuluModel;
import mosing.model.NilaiModel;

public interface LPTerdahuluService {
	void addNilai(NilaiModel nilai);
	List<LPTerdahuluModel> selectAllLPT();
}