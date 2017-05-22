package mosing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.PFakultasMapper;
import mosing.model.FakultasModel;

@Slf4j
@Service
public class PFakultasServiceDatabase implements PFakultasService {

	@Autowired
	PFakultasMapper pfakultasMapper;
	
	@Override
	public List<FakultasModel> selectAllFakultas() {
		// TODO Auto-generated method stub
		return pfakultasMapper.selectAllFakultas();
	}
}
