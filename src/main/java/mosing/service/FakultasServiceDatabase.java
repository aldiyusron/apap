package mosing.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.FakultasMapper;
import mosing.model.FakultasModel;

@Service
@Slf4j
public class FakultasServiceDatabase implements FakultasService{
	
	@Autowired
	FakultasMapper fakultasMapper;
	
	@Override
	public FakultasModel selectFakultas(int id_fakultas) {
		// TODO Auto-generated method stub
		return fakultasMapper.selectFakultas(id_fakultas);
	}

}
