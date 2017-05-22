package mosing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.DaftarPilihanMapper;
import mosing.model.DaftarPilihanModel;

@Service
@Slf4j
public class DaftarPilihanServiceDatabase implements DaftarPilihanService {
	
	@Autowired
	DaftarPilihanMapper daftarPilihanMapper;
	
	@Override
	public List<DaftarPilihanModel> selectPilihan(int no_daftar) {
		// TODO Auto-generated method stub
		return daftarPilihanMapper.selectPilihan(no_daftar);
	}

	@Override
	public DaftarPilihanModel selectPilihan2(int no_daftar) {
		// TODO Auto-generated method stub
		return daftarPilihanMapper.selectPilihan2(no_daftar);
	}

}
