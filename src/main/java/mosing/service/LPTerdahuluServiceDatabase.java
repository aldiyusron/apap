package mosing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.LPTerdahuluMapper;
import mosing.model.LPTerdahuluModel;
import mosing.model.NilaiModel;

@Slf4j
@Service
public class LPTerdahuluServiceDatabase implements LPTerdahuluService {

	@Autowired
	LPTerdahuluMapper lpterdahuluMapper;
	
	@Override
	public void addNilai(NilaiModel nilai)
	{
		lpterdahuluMapper.addNilai(nilai);
	}

	@Override
	public List<LPTerdahuluModel> selectAllLPT() {
		return lpterdahuluMapper.selectAllLPT();
	}

}
