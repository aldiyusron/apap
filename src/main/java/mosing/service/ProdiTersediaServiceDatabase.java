package mosing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.ProdiTersediaMapper;
import mosing.model.ProdiTersediaModel;

@Slf4j
@Service
public class ProdiTersediaServiceDatabase implements ProdiTersediaService {

	@Autowired
	ProdiTersediaMapper prodiMapper;
	
	@Override
	public ProdiTersediaModel selectProdi(int id_prodi)
	{
		return prodiMapper.selectProdi(id_prodi);
	}
	
	@Override
	public List<ProdiTersediaModel> selectAllProdi(int id_jalur)
	{
		return prodiMapper.selectAllProdi(id_jalur);
	}

	@Override
	public void addProdi(ProdiTersediaModel prodi) {
		prodiMapper.addProdi(prodi);
		
	}

	@Override
	public void updateProdi(ProdiTersediaModel prodi) {
		prodiMapper.updateProdi(prodi);
		
	}

	@Override
	public void deleteProdi(ProdiTersediaModel prodi) {
		prodiMapper.deleteProdi(prodi);
	}
}
