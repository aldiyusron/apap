package mosing.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.LPTerdahuluMapper;
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

}
