package mosing.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.ProdiTersediaMapper;
import mosing.model.ProdiTersediaModel;

@Service
@Slf4j
public class ProdiTersediaServiceDatabase implements ProdiTersediaService {

	@Autowired
	ProdiTersediaMapper prodiTersediaMapper;
	
	@Override
	public ProdiTersediaModel selectProdi(int id_prodi) {
		// TODO Auto-generated method stub
		return prodiTersediaMapper.selectProdi(id_prodi);
	}

}
