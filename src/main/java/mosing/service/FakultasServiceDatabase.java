package mosing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.FakultasMapper;
import mosing.model.FakultasModel;
import mosing.model.ProdiTersediaModel;

@Service
@Slf4j
public class FakultasServiceDatabase implements FakultasService {
	
	@Autowired
	FakultasMapper fakultasMapper;
	
	@Override
	public List<FakultasModel> selectAllFakultas() {
		// TODO Auto-generated method stub
		return fakultasMapper.selectAllFakultas();
	}

	@Override
	public FakultasModel selectFakultasDanProdi(int id_fakultas) {
		return fakultasMapper.selectFakultasDanProdi(id_fakultas);
	}

	@Override
	public List<ProdiTersediaModel> selectProdi(int id_fakultas) {
		// TODO Auto-generated method stub
		return fakultasMapper.selectProdi(id_fakultas);
	}
	
	@Override
	public FakultasModel selectFakultas(int id_fakultas) {
		return fakultasMapper.selectFakultas(id_fakultas);
	}

}
